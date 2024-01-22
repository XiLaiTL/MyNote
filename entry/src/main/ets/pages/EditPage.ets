import CommonConstants from '../common/constants/CommonConstants'
import NoteInfo from '../common/bean/NoteInfo'
import { NoteSaveButtons } from '../view/NoteSaveButton'
import DateUtil from '../common/utils/DateUtil'
import Router from '@system.router'
import router from '@ohos.router'

@Entry
@Component
struct PageEdit {
  @State noteInfo: NoteInfo = { // 笔记信息
    id: 1,
    title: "",
    content: "",
    date: "",
    imageArr: ''
  }
  @State oldNoteInfo: NoteInfo = { // 笔记信息
    id: 1,
    title: "",
    content: "",
    date: "",
    imageArr: ''
  }
  @State change: boolean = false;
  @State imageArray: string [] = this.noteInfo.imageArr.length > 5 ? JSON.parse(this.noteInfo.imageArr): []

  isChange() {
    this.change = this.oldNoteInfo.title != this.noteInfo.title
      || this.oldNoteInfo.content != this.noteInfo.content
      || this.oldNoteInfo.imageArr != this.noteInfo.imageArr
  }

  build() {
    Column() {
      // 标题栏
      NoteSaveButtons({
        change: $change,
        back: (e) => {
          // todo 需要一个是否保存编辑内容 + 回去哪一面
          router.pushUrl({url:'pages/NotePage'})
        },
        save: (e) => {
          this.change = false
          this.noteInfo.date = DateUtil.getCurrentTime()
          // todo 更新笔记
        }
      })
      //
      Text(this.noteInfo.date + (this.noteInfo.content.length) + '字')
        .margin({
          top: 29, bottom: 13, left: 2
        })
        .fontColor($r('app.color.black_40'))
        .fontSize(CommonConstants.FONT_SIZE_17)
      // 笔记标题
      TextInput({
        text: this.noteInfo.title,
        placeholder: "标题"
      })
        .placeholderColor($r('app.color.black_40'))
        .fontSize(CommonConstants.FONT_SIZE_19)
        .borderWidth({ bottom: 1 })
        .borderColor($r('app.color.black_10'))
        .padding({
          left: 5
        })
        .backgroundColor(Color.Transparent)
        .height(58)
        .borderRadius(0)
        .margin({ bottom: 20 })
        .width('100%')
        .onChange((str) => {
          this.noteInfo.title = str;
          this.isChange();
        })
      // 笔记正文
      TextArea({
        text: this.noteInfo.content,
        placeholder: "正文"
      })
        .placeholderColor($r('app.color.black_40'))
        .padding({ left: 5 })
        .backgroundColor(Color.Transparent)
        .borderRadius(0)
        .height(160)
        .margin({ top: 10 })
        .onChange((str) => {
          this.noteInfo.content = str;
          this.isChange();
        })

      // 图片
      Grid() {
        ForEach(this.imageArray , (src) => {
          GridItem() {
            Image(src)
              .width(98)
              .height(98)
          }
        })
        GridItem() {
          Image($r("app.media.icon_add_image"))
            .width(98)
            .height(98)
            .onClick((e) => {
              // todo 添加图片
            })
        }
      }
      .columnsTemplate('1fr 1fr 1fr')
      .columnsGap(20)
      .rowsGap(20)
      .width(334)
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .padding({ left: CommonConstants.MARGIN_2, right: CommonConstants.MARGIN_2 })
    .backgroundColor($r('app.color.background'))
    .alignItems(HorizontalAlign.Start)
  }
}