# require 'rails_helper'
# require 'support/devise'
#
# describe 'layouts/application' do
#   before do
#     user = double('user')
#     render
#   end
#
#   context 'guest user' do
#     before do
#       allow(request.env['warden']).to receive(:authenticate!)
#         .and_throw(:warden, scope: user)
#     end
#
#     it "doesn't display Orders menu" do
#       expect(rendered).not_to include('Orders')
#     end
#
#     it "doesn't display Settings menu" do
#       expect(rendered).not_to include('Settings')
#     end
#   end
#
#   context 'logged in user' do
#     before do
#       allow(request.env['warden']).to receive(:authenticate!).and_return(user)
#       allow(controller).to receive(:current_user).and_return(user)
#     end
#
#     it "displays Orders menu" do
#       expect(rendered).to include('Orders')
#     end
#
#     it "displays Settings menu" do
#       expect(rendered).to include('Settings')
#     end
#   end
# end
