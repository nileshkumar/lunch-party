require 'rails_helper'

RSpec.describe "/teams", type: :request do

  let(:valid_attributes) {
    {
      name: Faker::Team.name 
    }
  }

  let(:invalid_attributes) {
    {
      name: ''
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Team.create! valid_attributes
      get teams_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      team = Team.create! valid_attributes
      get team_url(team)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_team_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      team = Team.create! valid_attributes
      get edit_team_url(team)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Team" do
        expect {
          post teams_url, params: { team: valid_attributes }
        }.to change(Team, :count).by(1)
      end

      it "redirects to the created team" do
        post teams_url, params: { team: valid_attributes }
        expect(response).to redirect_to(team_url(Team.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Team" do
        expect {
          post teams_url, params: { team: invalid_attributes }
        }.to change(Team, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post teams_url, params: { team: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {name: "Test team"}
      }

      it "updates the requested team" do
        team = Team.create! valid_attributes
        patch team_url(team), params: { team: new_attributes }
        team.reload
      end

      it "redirects to the team" do
        team = Team.create! valid_attributes
        patch team_url(team), params: { team: new_attributes }
        team.reload
        expect(response).to redirect_to(team_url(team))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        team = Team.create! valid_attributes
        patch team_url(team), params: { team: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested team" do
      team = Team.create! valid_attributes
      expect {
        delete team_url(team)
      }.to change(Team, :count).by(-1)
    end

    it "redirects to the teams list" do
      team = Team.create! valid_attributes
      delete team_url(team)
      expect(response).to redirect_to(teams_url)
    end
  end
end
