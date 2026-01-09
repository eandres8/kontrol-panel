import { Module } from '@nestjs/common';
import { CronsService } from './crons.service';
import { CronsController } from './crons.controller';

@Module({
  controllers: [CronsController],
  providers: [CronsService],
})
export class CronsModule {}
