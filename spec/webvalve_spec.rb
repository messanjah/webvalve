require 'spec_helper'

RSpec.describe WebValve do
  it 'delegates .setup to manager' do
    expect(described_class).to respond_to(:setup)
  end

  it 'delegates .register to manager' do
    expect(described_class).to respond_to(:register)
  end

  it 'delegates .reset to manager' do
    expect(described_class).to respond_to(:reset)
  end

  it 'delegates .whitelist_url to manager' do
    expect(described_class).to respond_to(:whitelist_url)
  end

  describe '.allow_service_connect?' do
    subject { described_class.allow_service_connect? }
    context 'in test env' do
      around do |ex|
        with_rails_env 'test' do
          ex.run
        end
      end
      it 'returns false by default' do
        expect(subject).to be false
      end
      context 'when a value is set' do
        around do |ex|
          with_allow_service_connect(test_value) do
            ex.run
          end
        end
        context 'when set to true' do
          let(:test_value) { true }
          it 'returns true' do
            expect(subject).to be true
          end
        end
        context 'when set to false' do
          let(:test_value) { false }
          it 'return false' do
            expect(subject).to be false
          end
        end
      end
    end
    context 'in development env' do
      around do |ex|
        with_rails_env 'development' do
          ex.run
        end
      end
      it 'returns true by default' do
        expect(subject).to be true
      end
      context 'when a value is set' do
        around do |ex|
          with_allow_service_connect(test_value) do
            ex.run
          end
        end
        context 'when set to true' do
          let(:test_value) { true }
          it 'returns true' do
            expect(subject).to be true
          end
        end
        context 'when set to false' do
          let(:test_value) { false }
          it 'return false' do
            expect(subject).to be false
          end
        end
      end
    end
  end
end
