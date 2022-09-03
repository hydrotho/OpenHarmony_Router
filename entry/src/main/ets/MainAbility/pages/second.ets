import router from '@ohos.router';

@Entry
@Component
struct Second {
  abilityName: string = 'Ability One'
  pageName: string = 'Page Two'
  method: string = 'Method: @ohos.router'

  build() {
    Row() {
      Column() {
        Text(this.abilityName)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .margin(10)
        Text(this.pageName)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .margin(10)
        Button({ type: ButtonType.Capsule, stateEffect: true }) {
          Text('Back')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width(100)
        .height(50)
        .margin(50)
        .onClick(() => router.back())

        Text(this.method)
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .margin(10)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
    }
    .height('100%')
  }
}