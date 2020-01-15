import { CashMarginTypeStrategy } from './types';
import BrokerApi from './BrokerApi';
import symbols from '../symbols';
import {  ConfigStore } from '../types';
import container from '../container.config';

export default class CashStrategy implements CashMarginTypeStrategy {
  private configStore: ConfigStore;

  constructor(private readonly brokerApi: BrokerApi) {
    this.configStore = container.get<ConfigStore>(symbols.ConfigStore);

  }

  async getBtcPosition(): Promise<number> {
    const accounts = await this.brokerApi.getAccountBalance();
    const account = accounts.find(b => b.currency === this.configStore.config.symbolFrom );
    if (account === undefined) {
      throw new Error ('Unable to find the account.');
    }
    return account.balance;
  }
}
