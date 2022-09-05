import wantAgent from '@ohos.wantAgent';

@Entry
@Component
struct Index {
  abilityName: string = 'Ability WantAgent'
  method: string = 'Method: @ohos.wantAgent'

  startAbilityViaWantAgent(bundleName: string, abilityName: string) {
    let wantAgentInfo = {
      wants: [
        {
          bundleName: bundleName,
          abilityName: abilityName
        }
      ],
      operationType: wantAgent.OperationType.START_ABILITY,
      requestCode: 0,
      wantAgentFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG]
    }

    wantAgent.getWantAgent(wantAgentInfo, (error, wantAgentObj) => {
      if (error.code) {
        console.error("[WantAgent]getWantAgent error: " + JSON.stringify(error))
      } else {
        console.log("[WantAgent]getWantAgent success")
        let triggerInfo = {
          code: 0
        }
        wantAgent.trigger(wantAgentObj, triggerInfo, (completeData) => {
          console.log("[WantAgent]getWantAgent success, completeData: ", +JSON.stringify(completeData))
        })
      }
    })
  }

  build() {
    Row() {
      Column() {
        Text(this.abilityName)
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
        .onClick(() => this.startAbilityViaWantAgent('com.github.hydrotho.router', 'com.example.entry.MainAbility'))

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