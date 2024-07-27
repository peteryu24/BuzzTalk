import { MigrationInterface, QueryRunner } from 'typeorm';

export class Migration1722037095589 implements MigrationInterface {
  name = 'Migration1722037095589';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "start_time"`);
    await queryRunner.query(
      `ALTER TABLE "room" ADD "start_time" character varying NOT NULL`,
    );
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "end_time"`);
    await queryRunner.query(
      `ALTER TABLE "room" ADD "end_time" character varying NOT NULL`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "end_time"`);
    await queryRunner.query(
      `ALTER TABLE "room" ADD "end_time" TIMESTAMP WITH TIME ZONE NOT NULL`,
    );
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "start_time"`);
    await queryRunner.query(
      `ALTER TABLE "room" ADD "start_time" TIMESTAMP WITH TIME ZONE NOT NULL`,
    );
  }
}
