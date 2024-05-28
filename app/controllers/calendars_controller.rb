class CalendarsController < ApplicationController
  # １週間のカレンダーと予定が表示されるページ

  def index
    get_week

    @plan = Plan.new
  end

  # 予定の保存
  def create
    @plan = Plan.new (plan_params)
    if @plan.save
      redirect_to action: :index
    else
      get_week
      render :index
    end
  end

  private

  def plan_params
    params.require(:calendars).permit(:date, :plan)
  end

  def get_week

    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']


    days = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']


    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end

      wday_num = (@todays_date + x).wday# wdayメソッドを用いて取得した数値
      if wday_num >= 7
        wday_num = wday_num -7
      end

      @week_days.push(days)
    end

  end
end
