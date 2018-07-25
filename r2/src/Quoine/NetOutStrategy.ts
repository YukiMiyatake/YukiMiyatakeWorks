import { CashMarginTypeStrategy } from './types';
import BrokerApi from './BrokerApi';
import * as _ from 'lodash';

export default class NetOutStrategy implements CashMarginTypeStrategy {
  constructor(private readonly brokerApi: BrokerApi) {}

  async getBtcPosition(): Promise<number> {
    const accounts = await this.brokerApi.getTradingAccounts();
    const account = _.find(accounts, b => b.currency_pair_code === 'BTCETH');
    if (!account) {
      throw new Error('Unable to find the account.2');
    }
    return account.position;
  }
}
