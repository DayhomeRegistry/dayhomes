require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe Admin::AgenciesController do

  before(:each) do
    @attr = FactoryGirl.attributes_for(:agency)
    login_admin_user
  end

  # This should return the minimal set of attributes required to create a valid
  # Agency. As you add validations to Agency, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    @attr
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Admin::AgenciesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all admin_agencies as @agencies" do
      agency = Agency.create! valid_attributes
      get :index, {}, valid_session
      assigns(:agencies).should eq([agency])
    end
  end

  describe "GET show" do
    it "assigns the requested agency as @agency" do
      agency = Agency.create! valid_attributes
      get :show, {:id => agency.to_param}, valid_session
      assigns(:agency).should eq(agency)
    end
  end

  describe "GET new" do
    it "assigns a new agency as @agency" do
      get :new, {}, valid_session
      assigns(:agency).should be_a_new(Agency)
    end
  end

  describe "GET edit" do
    it "assigns the requested agency as @agency" do
      agency = Agency.create! valid_attributes
      get :edit, {:id => agency.to_param}, valid_session
      assigns(:agency).should eq(agency)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Agency" do
        expect {
          post :create, {:agency => valid_attributes}, valid_session
        }.to change(Agency, :count).by(1)
      end

      it "assigns a newly created agency as @agency" do
        post :create, {:agency => valid_attributes}, valid_session
        assigns(:agency).should be_a(Agency)
        assigns(:agency).should be_persisted
      end

      it "redirects to the created agency" do
        post :create, {:agency => valid_attributes}, valid_session
        response.should redirect_to(admin_agency_path(Agency.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved agency as @agency" do
        # Trigger the behavior that occurs when invalid params are submitted
        Agency.any_instance.stub(:save).and_return(false)
        post :create, {:agency => {}}, valid_session
        assigns(:agency).should be_a_new(Agency)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Agency.any_instance.stub(:save).and_return(false)
        post :create, {:agency => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested agency" do
        agency = Agency.create! valid_attributes
        # Assuming there are no other admin_agencies in the database, this
        # specifies that the Agency created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Agency.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => agency.to_param, :agency => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested agency as @agency" do
        agency = Agency.create! valid_attributes
        put :update, {:id => agency.to_param, :agency => valid_attributes}, valid_session
        assigns(:agency).should eq(agency)
      end

      it "redirects to the agency" do
        agency = Agency.create! valid_attributes
        put :update, {:id => agency.to_param, :agency => valid_attributes}, valid_session
        response.should redirect_to(admin_agency_path(agency))
      end
    end

    describe "with invalid params" do
      it "assigns the agency as @agency" do
        agency = Agency.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Agency.any_instance.stub(:save).and_return(false)
        put :update, {:id => agency.to_param, :agency => {}}, valid_session
        assigns(:agency).should eq(agency)
      end

      it "re-renders the 'edit' template" do
        agency = Agency.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Agency.any_instance.stub(:save).and_return(false)
        put :update, {:id => agency.to_param, :agency => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested agency" do
      agency = Agency.create! valid_attributes
      expect {
        delete :destroy, {:id => agency.to_param}, valid_session
      }.to change(Agency, :count).by(-1)
    end

    it "redirects to the admin_agencies list" do
      agency = Agency.create! valid_attributes
      delete :destroy, {:id => agency.to_param}, valid_session
      response.should redirect_to(admin_agencies_url)
    end
  end

end
