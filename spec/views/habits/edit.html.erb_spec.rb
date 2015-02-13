require 'spec_helper'

describe "habits/edit" do
  before(:each) do
    @habit = assign(:habit, stub_model(Habit,
      :user_id => 1,
      :target => "MyString"
    ))
  end

  it "renders the edit habit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", habit_path(@habit), "post" do
      assert_select "input#habit_user_id[name=?]", "habit[user_id]"
      assert_select "input#habit_target[name=?]", "habit[target]"
    end
  end
end
