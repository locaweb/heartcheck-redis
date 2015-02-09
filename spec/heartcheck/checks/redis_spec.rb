RSpec.describe Heartcheck::Checks::Redis do
  let(:connection) { ::Redis.new }
  let(:check_errors) { subject.instance_variable_get(:@errors) }
  subject do
    described_class.new.tap do |c|
      c.add_service(name: 'Default check', connection: connection)
    end
  end

  describe '#validate' do
    context 'with success' do
      it 'calls set get and delete' do
        expect(connection).to receive(:set).and_call_original
        expect(connection).to receive(:get).and_call_original
        expect(connection).to receive(:del).and_call_original
        subject.validate
        expect(check_errors).to be_empty
      end
    end

    context 'with error' do
      before do
        allow(connection).to receive(:set).and_return('error')
        allow(connection).to receive(:get).and_return(nil)
        allow(connection).to receive(:del).and_return(0)
      end

      it 'sets error for each action' do
        error_messages = [
          'Default check fails to set',
          'Default check fails to get',
          'Default check fails to delete'
        ]
        subject.validate
        expect(check_errors).to match_array(error_messages)
      end

      it 'uses custom error message' do
        error_messages = [
          "Default check can't set a value",
          "Default check can't get a value",
          "Default check can't delete a value"
        ]
        subject.on_error do |errors, service, key_error|
          errors << "#{service[:name]} can't #{key_error} a value"
        end
        subject.validate

        expect(check_errors).to match_array(error_messages)
      end
    end
  end
end
