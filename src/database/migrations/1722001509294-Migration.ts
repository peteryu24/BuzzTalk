import { MigrationInterface, QueryRunner } from 'typeorm';

export class Migration1722001509294 implements MigrationInterface {
  name = 'Migration1722001509294';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "topic" DROP COLUMN "createdAt"`);
    await queryRunner.query(`ALTER TABLE "topic" DROP COLUMN "updatedAt"`);
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "startTime"`);
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "endTime"`);
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "topicId"`);
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "playerId"`);
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "createdAt"`);
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "updatedAt"`);
    await queryRunner.query(
      `ALTER TABLE "topic" ADD "created_at" TIMESTAMP NOT NULL DEFAULT now()`,
    );
    await queryRunner.query(
      `ALTER TABLE "topic" ADD "updated_at" TIMESTAMP NOT NULL DEFAULT now()`,
    );
    await queryRunner.query(
      `ALTER TABLE "room" ADD "start_time" TIMESTAMP NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "room" ADD "end_time" TIMESTAMP NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "room" ADD "topic_id" integer NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "room" ADD "player_id" integer NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "room" ADD "created_at" TIMESTAMP NOT NULL DEFAULT now()`,
    );
    await queryRunner.query(
      `ALTER TABLE "room" ADD "updated_at" TIMESTAMP NOT NULL DEFAULT now()`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "updated_at"`);
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "created_at"`);
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "player_id"`);
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "topic_id"`);
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "end_time"`);
    await queryRunner.query(`ALTER TABLE "room" DROP COLUMN "start_time"`);
    await queryRunner.query(`ALTER TABLE "topic" DROP COLUMN "updated_at"`);
    await queryRunner.query(`ALTER TABLE "topic" DROP COLUMN "created_at"`);
    await queryRunner.query(
      `ALTER TABLE "room" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`,
    );
    await queryRunner.query(
      `ALTER TABLE "room" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`,
    );
    await queryRunner.query(
      `ALTER TABLE "room" ADD "playerId" integer NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "room" ADD "topicId" integer NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "room" ADD "endTime" TIMESTAMP NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "room" ADD "startTime" TIMESTAMP NOT NULL`,
    );
    await queryRunner.query(
      `ALTER TABLE "topic" ADD "updatedAt" TIMESTAMP NOT NULL DEFAULT now()`,
    );
    await queryRunner.query(
      `ALTER TABLE "topic" ADD "createdAt" TIMESTAMP NOT NULL DEFAULT now()`,
    );
  }
}
