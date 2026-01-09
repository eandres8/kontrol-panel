import * as joi from 'joi';

type EnvVars = {
  APP_PORT: number;
  NODE_ENV: string;
};

const envSchema = joi
  .object<EnvVars>({
    APP_PORT: joi.number().required(),
    NODE_ENV: joi.string().required(),
  })
  .unknown(true);

// eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
const { error, value } = envSchema.validate(process.env);

if (error) {
  throw new Error(`Config validation error: ${error}`);
}

export const envs: EnvVars = value;
