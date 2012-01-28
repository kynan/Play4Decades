require File.dirname(__FILE__) + '/../spec_helper'

describe TeamRoundsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => TeamRound.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    TeamRound.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    TeamRound.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(team_round_url(assigns[:team_round]))
  end

  it "edit action should render edit template" do
    get :edit, :id => TeamRound.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    TeamRound.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TeamRound.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    TeamRound.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TeamRound.first
    response.should redirect_to(team_round_url(assigns[:team_round]))
  end

  it "destroy action should destroy model and redirect to index action" do
    team_round = TeamRound.first
    delete :destroy, :id => team_round
    response.should redirect_to(team_rounds_url)
    TeamRound.exists?(team_round.id).should be_false
  end
end
