import { MigrationInterface, QueryRunner } from 'typeorm';

export class Migration1722033520840 implements MigrationInterface {
  name = 'Migration1722033520840';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `CREATE TABLE "player" ("id" SERIAL NOT NULL, "uuid" character varying NOT NULL, "created_at" TIMESTAMP NOT NULL DEFAULT now(), "updated_at" TIMESTAMP NOT NULL DEFAULT now(), CONSTRAINT "PK_65edadc946a7faf4b638d5e8885" PRIMARY KEY ("id"))`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP TABLE "player"`);
  }
}
