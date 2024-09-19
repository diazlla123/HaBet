class ReportsController < ApplicationController
  def show

    @group = Group.find(params[:group_id])
    @member = Member.find(params[:member_id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Group Report",
               template: "reports/show"
      end
    end
  end
end
