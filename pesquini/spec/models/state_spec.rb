=begin
File: state_spec.rb.
Purpose: Contains a unit test from class State.
License: GPL v3.
Pesquini Group 6.
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

require "spec_helper"
require "rails_helper"

describe State do

  before do

    @state = State.new
    @state.abbreviation = "DF1"
    @state.save

  end

  subject {@state}
    it { should respond_to(:abbreviation) }
    it { should respond_to(:id) }
    it { should respond_to(:code) }
    it { should respond_to(:name) }
  it { should be_valid }

  describe "uniqueness validation of abbreviation" do
    
    describe "unique abbreviation" do

      it "should be_valid" do
        uniqueness_state = State.new
        uniqueness_state.abbreviation = "SP1"
        uniqueness_state.save 
        expect( uniqueness_state ).to be_valid
      end

    end

   describe "duplicated abbreviation" do

        it "should not be_valid" do
        duplicated_state = State.new
        duplicated_state.abbreviation = "DF1" 
        expect( duplicated_state ).not_to be_valid
      end

    end


    describe "#refresh!" do
   
      before do
   
        @s = State.new
        @s.abbreviation = "Es_Teste"
        @s.save
   
      end

      it "should return state" do
        expect( @s.refresh! ).to eq( @s );
      end

      it "should not return other state" do
        expect( @s.refresh! ).not_to eq( @state );
      end  
   
    end
    
  end

end
