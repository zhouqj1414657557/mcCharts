import DrawRadar from '../../utils/drawRadar'
import { Chart } from './Chart'
import { Options } from './Options'
import { InterfaceObj } from '../../utils/chartInterface'
import { globalBuilder } from './Tooltip'
import { Chart as CommonChart } from '../../utils/charts'
let drawMcLineChart: CommonChart;
@Component
export struct McRadarChart {
  @ObjectLink @Watch('onCountUpdated') options: Options;
  @State chartOption: Options = new Options({})
  @State renderType: string = 'init'
  private click: Function = (event: InterfaceObj, params: InterfaceObj) => {}
  private tooltipClick: Function = (event: InterfaceObj, params: InterfaceObj) => {}
  @BuilderParam customTooltip: (tooltipInfo: InterfaceObj) => void = globalBuilder; // 自定义组件
  // @Watch 回调
  onCountUpdated(): void {
    this.chartOption = new Options(this.options)
  }
  aboutToAppear() {
    this.onCountUpdated()
    drawMcLineChart = new DrawRadar()
  }
  build() {
    Chart({
      options: this.chartOption,
      drawMcChart: drawMcLineChart,
      renderType: this.renderType,
      customTooltip: this.customTooltip,
      click: (event: InterfaceObj, params: InterfaceObj) => {
        this.click(event, params)
      },
      tooltipClick: (event: InterfaceObj, params: InterfaceObj) => {
        this.tooltipClick(event, params)
      }
    })
  }
}

