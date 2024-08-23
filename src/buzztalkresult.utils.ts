export class BuzzTalkResult {
  response: { [key: string]: any } = {};

  //이거 msg int형으로 전부 수정
  resultError(msg: number): { [key: string]: any } {
    return this.result(false, msg, null);
  }

  successResult(data: any): { [key: string]: any } {
    return this.result(true, null, data);
  }

  result(chk: boolean, msg: number | null, data: any): { [key: string]: any } {
    const map: { [key: string]: any } = {};

    map['result'] = chk;
    map['msg'] = msg;
    map['data'] = data;

    return map;
  }

  handleError(e: any): { [key: string]: any } {
    // 에러 로깅을 추가하거나, 에러 메시지를 처리
    console.error('Error occurred:', e);

    return this.resultError(20);
  }
}
