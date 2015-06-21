require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.create!(full_name: "R.L. Stine",
                            display_name: "Stiner",
                            email: "goosebumps@rscary.com",
                            password: "aaah")}
  
  it "is valid" do
    expect(user).to be_valid
  end
  
  it "has valid attributes" do
    expect(user.full_name).to eq("R.L. Stine")
    expect(user.display_name).to eq("Stiner")
    expect(user.email).to eq("goosebumps@rscary.com")
    expect(user.password).to eq("aaah")
  end
  
  it "must have valid email" do
    user.email = "thisemailsucks"
    expect(user).to_not be_valid

    user.email = "thisemailsucks.com"
    expect(user).to_not be_valid

    user.email = "thisemailsucks@nocom"
    expect(user).to_not be_valid
    
    user.email = "this email sucks@email.com"
    expect(user).to_not be_valid

    user.email = ""
    expect(user).to_not be_valid
  end
  
  it "must have unique email" do
    user
    expect { User.create!(full_name: "R.L. NotStine",
                        display_name: "NotStiner",
                        email: "goosebumps@rscary.com",
                        password: "aaahhhh")
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "must have full name" do
    user.full_name = ""
    expect(user).to_not be_valid
  end
  
  it "must have a display name of appropriate length" do
    user.display_name = "R"
    expect(user).to_not be_valid

    user.display_name = "SSSSSSTTTTTTTTTTEEEEEEEELLLLLLLLLLLLLLAAAAAAAA"
    expect(user).to_not be_valid
  end
  
  it "sets display name to full name if display name left blank" do
    user2 = User.create!(full_name: "Scary Ghost",
                         display_name: "",
                         email: "ghosts@rscary.com",
                         password: "aaah")
    expect(user2.display_name).to eq("Scary Ghost")
  end
  
  it "sets default role" do
    expect(user.role).to eq("default")
  end
end
