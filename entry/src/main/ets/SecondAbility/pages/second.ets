import featureAbility from '@ohos.ability.featureAbility';

@Entry
@Component
struct Second {
  abilityName: string = 'Ability Two'
  pageName: string = 'Page Two'
  method: string = 'Method: @ohos.ability.featureAbility with parameters'

  startAbility(bundleName: string, abilityName: string, parameters = {}) {
    let want = {
      bundleName: bundleName,
      abilityName: abilityName,
      parameters: parameters
    }
    try {
      featureAbility.startAbility({ want: want }).then(() => featureAbility.terminateSelf());
    } catch (err) {
      console.info(`Fail in startAbility(), code: ${err.code}, msg: ${err.msg}`)
    }
  }

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
        .onClick(() => this.startAbility('com.github.hydrotho.router', 'com.example.entry.MainAbility'))

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