import { Module } from '@nestjs/common';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './features/auth/auth.module';
import { FeatureFlagsModule } from './features/feature-flags/feature-flags.module';
import { CronsModule } from './features/crons/crons.module';

@Module({
  imports: [AuthModule, FeatureFlagsModule, CronsModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
