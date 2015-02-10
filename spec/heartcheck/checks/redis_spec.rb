RSpec.describe Heartcheck::Checks::Redis do
  let(:connection) { ::Redis.new }
  let(:check_errors) { subject.instance_variable_get(:@errors) }

  subject do
    described_class.new.tap do |c|
      c.add_service(name: 'Default check', connection: connection)
    end
  end

  describe '#validate' do
    context 'when nothing fails' do
      it 'calls set get and delete' do
        expect(connection).to receive(:set).and_call_original
        expect(connection).to receive(:get).and_call_original
        expect(connection).to receive(:del).and_call_original
        subject.validate
        expect(check_errors).to be_empty
      end
    end

    context 'when something fails' do
      before do
        allow(connection).to receive(:set).and_return('error')
        allow(connection).to receive(:get).and_return(nil)
        allow(connection).to receive(:del).and_return(0)
      end

      context 'with default errors' do
        before do
          subject.validate
        end

        it { expect(check_errors).to include('Default check fails to set') }
        it { expect(check_errors).to include('Default check fails to get') }
        it { expect(check_errors).to include('Default check fails to delete') }
      end

      context 'with custom errors' do
        before do
          subject.on_error do |errors, name, key_error|
            errors << "#{name} can't #{key_error} a value"
          end
          subject.validate
        end

        context 'get' do
          let(:msg) { 'Default check can\'t set a value' }
          it { expect(check_errors).to include(msg) }
        end

        context 'get' do
          let(:msg) { 'Default check can\'t get a value' }
          it { expect(check_errors).to include(msg) }
        end

        context 'get' do
          let(:msg) { 'Default check can\'t delete a value' }
          it { expect(check_errors).to include(msg) }
        end

      end
    end
  end
end
