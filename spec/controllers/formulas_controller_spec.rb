require 'spec_helper'

describe FormulasController do
  render_views
  describe "index" do
    before do
      Formula.create!(name: 'Baked Potato w/ Cheese')
      Formula.create!(name: 'Garlic Mashed Potatoes')
      Formula.create!(name: 'Potatoes Au Gratin')
      Formula.create!(name: 'Baked Brussel Sprouts')

      xhr :get, :index, format: :json, keywords: keywords
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_name
      ->(object) { object["name"] }
    end

    context "when the search finds results" do
      let(:keywords) { 'baked' }
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return two results' do
        expect(results.size).to eq(2)
      end
      it "should include 'Baked Potato w/ Cheese'" do
        expect(results.map(&extract_name)).to include('Baked Potato w/ Cheese')
      end
      it "should include 'Baked Brussel Sprouts'" do
        expect(results.map(&extract_name)).to include('Baked Brussel Sprouts')
      end
    end

    context "when the search doesn't find results" do
      let(:keywords) { 'foo' }
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end

  describe "show" do
    before do
      xhr :get, :show, format: :json, id: formula_id
    end

    subject(:results) { JSON.parse(response.body) }

    context "when the formula exists" do
      let(:formula) {
        Formula.create!(name: 'Baked Potato w/ Cheese',
               instructions: "Nuke for 20 minutes; top with cheese")
      }
      let(:formula_id) { formula.id }

      it { expect(response.status).to eq(200) }
      it { expect(results["id"]).to eq(formula.id) }
      it { expect(results["name"]).to eq(formula.name) }
      it { expect(results["instructions"]).to eq(formula.instructions) }
    end

    context "when the formula doesn't exit" do
      let(:formula_id) { -9999 }
      it { expect(response.status).to eq(404) }
    end
  end
end
