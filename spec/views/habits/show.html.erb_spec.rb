require 'spec_helper'

describe "habits/show" do
  before(:each) do
    @habit = assign(:habit, stub_model(Habit,
      :user_id => 1,
      :target => "Target"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Target/)
  end
end
