class MpsController < ApplicationController
  def index
    @members = Member.commons.active.alphabetical
  end

  def show
    begin
      @member = Member.find_by( member_id: params[:id] ) 
    rescue Mongoid::Errors::DocumentNotFound
      @member = nil
    end
  end

  def search
  end
end
