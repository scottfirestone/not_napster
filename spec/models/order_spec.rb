# require 'rails_helper'
#
# RSpec.describe Order, type: :model do
#   it "can total the order" do
#
#     expect(Order.new.total_order).to eq(2.0)
#   end
#
#   it "returns bottom five students" do
#     student1 = Student.create(first_name: "Bob", current_score: 1)
#     student2 = Student.create(first_name: "Tom", current_score: 2)
#     student3 = Student.create(first_name: "Frank", current_score: 3)
#     student4 = Student.create(first_name: "Rick", current_score: 4)
#     student5 = Student.create(first_name: "Greg", current_score: 5)
#     student6 = Student.create(first_name: "Sally", current_score: 6)
#
#     expect(Student.get_bottom_five.length).to eq(5)
#     expect(Student.get_bottom_five.include?(student6)).to eq(false)
#   end
# end
