require 'spec_helper'

describe "habits/index" do
  before(:each) do
    assign(:habits, [
      stub_model(Habit,
        :user_id => 1,
        :target => "Target"
      ),
      stub_model(Habit,
        :user_id => 1,
        :target => "Target"
      )
    ])
  end

  it "renders a list of habits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Target".to_s, :count => 2
  end
end
