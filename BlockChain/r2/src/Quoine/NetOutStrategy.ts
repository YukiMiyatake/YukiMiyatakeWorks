import { CashMarginTypeStrategy } from './types';
import BrokerApi from './BrokerApi';
import * as _ from 'lodash';
import symbols from '../symbols';
import {  ConfigStore } from '../types';
import container from '../container.config';

export default class NetOutStrategy implements CashMarginTypeStrategy {
  constructor(private readonly brokerApi: BrokerApi) {}

  async getBtcPosition(): Promise<number> {
    const configStore = container.get<ConfigStore>(symbols.ConfigStore);
    const accounts = await this.brokerApi.getTradingAccounts();
    const account = _.find(accounts, b => b.currency_pair_code === configStore.config.symbolFrom + configStore.config.symbolTo);
    if (!account) {
      throw new Error('Unable to find the account.');
    }
    return account.position;
  }
}
