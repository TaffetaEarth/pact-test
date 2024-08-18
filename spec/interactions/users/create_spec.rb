require "rails_helper"

RSpec.describe Users::Create do
  context 'when input params valid' do
    let!(:skill) { Skill.create(name: "skill") }
    let!(:interest) { Interest.create(name: "interest") }
    let(:user) { User.last }

    let(:params) do
      {
        name: 'name',
        surname: 'surname',
        patronymic: 'patronymic',
        email: 'email',
        nationality: 'nation',
        country: 'country',
        gender: 'male',
        age: 21,
        interests: [ 'interest' ],
        skills: [ 'skill' ]
      }
    end

    it 'executes properly' do
      expect { described_class.run(params: params) }.to change(User, :count).by(1)
      expect(user.interest_ids).to include(interest.id)
      expect(user.skill_ids).to include(skill.id)
    end
  end

  context 'when input params invalid' do
    context 'when gender invalid' do
      let(:params) do
        {
          name: 'name',
          surname: 'surname',
          patronymic: 'patronymic',
          email: 'email',
          nationality: 'nation',
          country: 'country',
          gender: 'male1',
          age: 21,
          interests: [ 'interest' ],
          skills: [ 'skill' ]
        }
      end

      it 'does not execute' do
        expect { described_class.run!(params: params) }.to raise_error(ActiveInteraction::InvalidInteractionError, "Gender should be male or female")
      end
    end

    context 'when age invalid' do
      let(:params) do
        {
          name: 'name',
          surname: 'surname',
          patronymic: 'patronymic',
          email: 'email',
          nationality: 'nation',
          country: 'country',
          gender: 'male',
          age: 100,
          interests: [ 'interest' ],
          skills: [ 'skill' ]
        }
      end

      it 'does not execute' do
        expect { described_class.run!(params: params) }.to raise_error(ActiveInteraction::InvalidInteractionError, "Age should be between 0 and 90")
      end
    end

    context 'when email already in use' do
      let!(:user) { User.create(email: "mail") }

      let(:params) do
        {
          name: 'name',
          surname: 'surname',
          patronymic: 'patronymic',
          email: user.email,
          nationality: 'nation',
          country: 'country',
          gender: 'male',
          age: 21,
          interests: [ 'interest' ],
          skills: [ 'skill' ]
        }
      end

      it 'does not execute' do
        expect { described_class.run!(params: params) }.to raise_error(ActiveInteraction::InvalidInteractionError, "Email already in use")
      end
    end

    context 'when params blank' do
      it 'does not execute' do
        expect { described_class.run!(params: {}) }.to raise_error(ActiveInteraction::InvalidInteractionError)
      end
    end
  end
end
