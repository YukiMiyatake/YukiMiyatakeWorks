import { hmac, nonce, safeQueryStringStringify } from '../util';
import WebClient from '../WebClient';
import {
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
    this.broker = new ccxt.bitflyer  ({ 
      'apiKey': this.key, 
      'secret': this.secret
    })
  }

  async sendChildOrder(request: SendChildOrderRequest): Promise<SendChildOrderResponse> {
    const path = '/v1/me/sendchildorder';
    return new SendChildOrderResponse(await this.post<SendChildOrderResponse, SendChildOrderRequest>(path, request));
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
    const path = '/v1/me/getexecutions';
    const response = await this.get<ExecutionsResponse, ExecutionsParam>(path, param);
    return response.map(x => new Execution(x));
  }

  async getBalance(): Promise<BalanceResponse> {
    let balance = await this.broker.fetchBalance ()
    //console.log(balance);

 return balance.info.map(x => new Balance(x));
 


//    const path = '/v1/me/getbalance';
//    const response = await this.get<BalanceResponse>(path);
 //   return response.map(x => new Balance(x));
  }

  async getBoard(): Promise<BoardResponse> {
/*
    let result = await this.broker.fetchOrderBook( 'BTC/JPY');
 console.log(new BoardResponse(result));

    return new BoardResponse( await this.broker.fetchOrderBook( 'BTC/JPY') );
*/
let result = await this.broker.fetchOrderBook( 'BTC/JPY');
//console.log(new BoardResponse(result));
console.log(new BoardResponse(result));

var bids = result.bids.map(x => new PriceSizePair( {price: x[0], size: x[1] }) );
var asks = result.asks.map(x => new PriceSizePair( {price: x[0], size: x[1] }) );

console.log( new BoardResponse( {bids:bids, asks:asks } ));
const path = '/v1/board';
console.log( new BoardResponse(await this.webClient.fetch<BoardResponse>(path, undefined, false)));
//console.log( result.mid_price );

return new BoardResponse( { bids:bids, asks:asks } );

/*
const path = '/v1/board';

    console.log( new BoardResponse(await this.webClient.fetch<BoardResponse>(path, undefined, false)));
    return new BoardResponse(await this.webClient.fetch<BoardResponse>(path, undefined, false));
    */
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
