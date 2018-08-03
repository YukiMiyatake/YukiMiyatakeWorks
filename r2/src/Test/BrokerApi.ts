import { hmac, nonce, safeQueryStringStringify } from '../util';
import WebClient from '../WebClient';
import {
  CcxtSendChildOrderRequest,
  SendChildOrderRequest,
  SendChildOrderResponse,
  CancelChildOrderRequest,
  CancelChildOrderResponse,
  ChildOrdersParam,
  ChildOrdersResponse,
  ExecutionsResponse,
  ExecutionsParam,
  Execution,
  BalanceResponse,
  PriceSizePair,
  BoardResponse,
  ChildOrder,
  Balance
} from './types';
import * as ccxt from 'ccxt';

export default class BrokerApi {
  private readonly baseUrl = 'https://api.bitflyer.jp';
  private readonly webClient: WebClient = new WebClient(this.baseUrl);
  private broker;

  constructor(private readonly key: string, private readonly secret: string) {
    this.broker = new ccxt.bitflyer({ 
      'apiKey': this.key, 
      'secret': this.secret
    })
  }

  async sendChildOrder(request: SendChildOrderRequest): Promise<SendChildOrderResponse> {
    var req = await new CcxtSendChildOrderRequest({
      symbol: "BTC/JPY",
      type: "limit",
      side: request.side,
      amount: request.size,
      price: request.price
//      params?: any     
    });

    return new SendChildOrderResponse( {child_order_acceptance_id: this.broker.createOrder(req).id });
  }

  async cancelChildOrder(request: CancelChildOrderRequest): Promise<CancelChildOrderResponse> {
    const path = '/v1/me/cancelchildorder';
    return await this.post<CancelChildOrderResponse, CancelChildOrderRequest>(path, request);
  }

  async getChildOrders(param: ChildOrdersParam): Promise<ChildOrdersResponse> {
    const path = '/v1/me/getchildorders';
    const response = await this.get<ChildOrdersResponse, ChildOrdersParam>(path, param);
    return response.map(x => new ChildOrder(x));
  }

  async getExecutions(param: ExecutionsParam): Promise<ExecutionsResponse> {
    var result = await this.broker.fetchTrades('BTC/JPY', 30);

    return (result.map(x => {
      new Execution({
        id: x.info.id,
        side: x.info.side,
        price: x.info.price,
        size: x.info.size,
        exec_date: x.info.exec_date,
        child_order_acceptance_id: x.order
      });
    }));
  }

  async getBalance(): Promise<BalanceResponse> {
    var balance = await this.broker.fetchBalance ()
    //console.log(balance);
    return balance.info.map(x => new Balance(x));
  }

  // 非同期処理もっと工夫したいがMockなので
  async getBoard(): Promise<BoardResponse> {
    var result = await this.broker.fetchOrderBook( 'BTC/JPY');
    //console.log(new BoardResponse(result));
    var bids = result.bids.map(x => new PriceSizePair( {price: x[0], size: x[1] }) );
    var asks = result.asks.map(x => new PriceSizePair( {price: x[0], size: x[1] }) );

    //console.log( new BoardResponse( {bids:bids, asks:asks } ));
    return new BoardResponse( { bids:bids, asks:asks } );

  }

  private async call<R>(path: string, method: string, body: string = ''): Promise<R> {
    const n = nonce();
    const message = n + method + path + body;
    const sign = hmac(this.secret, message);
    const headers = {
      'Content-Type': 'application/json',
      'ACCESS-KEY': this.key,
      'ACCESS-TIMESTAMP': n,
      'ACCESS-SIGN': sign
    };
    const init = { method, headers, body };
    return await this.webClient.fetch<R>(path, init);
  }

  private async post<R, T>(path: string, requestBody: T): Promise<R> {
    const method = 'POST';
    const body = JSON.stringify(requestBody);
    return await this.call<R>(path, method, body);
  }

  private async get<R, T = never>(path: string, requestParam?: T): Promise<R> {
    const method = 'GET';
    let pathWithParam = path;
    if (requestParam) {
      const param = safeQueryStringStringify(requestParam);
      pathWithParam += `?${param}`;
    }
    return await this.call<R>(pathWithParam, method);
  }
}
