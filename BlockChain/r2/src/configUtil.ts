import * as path from 'path';
import * as fs from 'fs';
import { ConfigRoot, Broker, BrokerConfig } from './types';
import { readJsonFileSync } from './util';
import * as _ from 'lodash';

const defaultValues = {
  symbolFrom: 'ETH',
  symbolTo: 'JPY'
};

export function getConfigRoot(): ConfigRoot {
  let configPath = getConfigPath();
  if (!fs.existsSync(configPath)) {
    configPath = path.join(process.cwd(), path.basename(configPath));
  }
  const config = new ConfigRoot(readJsonFileSync(configPath));
  return _.defaultsDeep({}, config, defaultValues);
}

export function getConfigPath(): string {
  const configFile=  process.argv[2] || "config.json";
  return process.env.NODE_ENV !== 'test' ? `${process.cwd()}/${configFile}}` : `${__dirname}/__tests__/${configFile}`;
}

export function findBrokerConfig(configRoot: ConfigRoot, broker: Broker): BrokerConfig {
  const found = configRoot.brokers.find(brokerConfig => brokerConfig.broker === broker);
  if (found === undefined) {
    throw new Error(`Unable to find ${broker} in config.`);
  }
  return found;
}
