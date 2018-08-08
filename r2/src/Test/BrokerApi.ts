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
import symbols from '../symbols';
import {  ConfigStore } from '../types';
import container from '../container.config';


export default class BrokerApi {
  private broker;
  private configStore: ConfigStore;

  constructor(
    private readonly key: string
    , private readonly secret: string

  ) {
    this.broker = new ccxt.bitflyer({ 
      'apiKey': this.key, 
      'secret': this.secret
    })
    this.configStore = container.get<ConfigStore>(symbols.ConfigStore);
  }

  // no test
  async sendChildOrder(request: SendChildOrderRequest): Promise<SendChildOrderResponse> {
    var req = await new CcxtSendChildOrderRequest({
      symbol: this.configStore.config.symbolFrom + '/' +  this.configStore.config.symbolTo,
      type: "limit",
      side: request.side,
      amount: request.size,
      price: request.price
//      params?: any     
    });

    return new SendChildOrderResponse( {child_order_acceptance_id: this.broker.createOrder(req).id });
  }

  // no test
  async cancelChildOrder(request: CancelChildOrderRequest): Promise<CancelChildOrderResponse> {
    return await this.broker.cancelOrder({id: request.child_order_acceptance_id, symbol: this.configStore.config.symbolFrom + '/' +  this.configStore.config.symbolTo });
  }

  // no test
  async getChildOrders(param: ChildOrdersParam): Promise<ChildOrdersResponse> {
    return await this.broker.fetchOrders({symbol: this.configStore.config.symbolFrom + '/' +  this.configStore.config.symbolTo, limit:50 }).map(x =>{      
      new ChildOrder(x.info);
    });
  }

  // no test
  async getExecutions(param: ExecutionsParam): Promise<ExecutionsResponse> {
    var result = await this.broker.fetchTrades(this.configStore.config.symbolFrom + '/' +  this.configStore.config.symbolTo, 30);

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
    var asks = result.asks.map(x => new PriceSizePair( {price: x[0], size: x[this.configStore.config.symbolFrom + '/' +  this.configStore.config.symbolTo] }) );

    //console.log( new BoardResponse( {bids:bids, asks:asks } ));
    return new BoardResponse( { bids:bids, asks:asks } );

  }

}
