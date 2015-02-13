require 'spec_helper'

describe "habits/new" do
  before(:each) do
    assign(:habit, stub_model(Habit,
      :user_id => 1,
      :target => "MyString"
    ).as_new_record)
  end

  it "renders new habit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", habits_path, "post" do
      assert_select "input#habit_user_id[name=?]", "habit[user_id]"
      assert_select "input#habit_target[name=?]", "habit[target]"
    end
  end
end
