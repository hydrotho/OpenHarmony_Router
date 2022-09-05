import featureAbility from '@ohos.ability.featureAbility';
import router from '@ohos.router';
import wantAgent from '@ohos.wantAgent';

@Entry
@Component
struct Index {
  abilityName: string = 'Ability One'
  pageName: string = 'Page One'

  async routePage(url: string, params = {}) {
    let options = {
      url: url,
      params: params
    }
    try {
      await router.push(options)
    } catch (err) {
      console.info(`Fail in routePage(), code: ${err.code}, msg: ${err.msg}`)
    }
  }

  async startAbility(bundleName: string, abilityName: string, parameters = {}) {
    let want = {
      bundleName: bundleName,
      abilityName: abilityName,
      parameters: parameters
    }
    try {
      await featureAbility.startAbility({ want: want });
    } catch (err) {
      console.info(`Fail in startAbility(), code: ${err.code}, msg: ${err.msg}`)
    }
  }

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
        Text(this.pageName)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .margin(10)
        Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
          Text('Route Without Passing Data')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)

          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Text('Go To Ability One Page Two')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .width(300)
          .height(50)
          .margin({ top: 10 })
          .onClick(() => this.routePage('pages/second'))

          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Text('Go To Ability Two Page One')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .width(300)
          .height(50)
          .margin({ top: 10 })
          .onClick(() => this.startAbility('com.github.hydrotho.router', 'com.example.entry.SecondAbility'))

          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Text('Go To Ability Two Page Two')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .width(300)
          .height(50)
          .margin({ top: 10 })
          .onClick(() => this.startAbility('com.github.hydrotho.router', 'com.example.entry.SecondAbility', { url: 'pages/second' }))

          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Text('Go To Ability WantAgent')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
          }
          .width(300)
          .height(50)
          .margin({ top: 10 })
          .onClick(() => this.startAbilityViaWantAgent('com.github.hydrotho.router', 'com.example.entry.WantAgentAbility'))

          Text('Route With Passing Data').fontSize(25)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 10 })

          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Text('Go To Ability One ParamPage')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .width(300)
          .height(50)
          .margin({ top: 10 })
          .onClick(() => this.routePage('pages/param', { data: `Route From ${this.abilityName} ${this.pageName}` }))

          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Text('Go To Ability Two Page One')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .width(300)
          .height(50)
          .margin({ top: 10 })
          .onClick(() => this.startAbility('com.github.hydrotho.router', 'com.example.entry.SecondAbility', { isPassingData: true }))

          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Text('Go To Ability Two Page Two')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .width(300)
          .height(50)
          .margin({ top: 10 })
          .onClick(() => this.startAbility('com.github.hydrotho.router', 'com.example.entry.SecondAbility', { url: 'pages/second', isPassingData: true }))
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}
