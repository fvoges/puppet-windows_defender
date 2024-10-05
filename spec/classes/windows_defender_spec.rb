require 'spec_helper'

describe 'windows_defender' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it {
        is_expected.to contain_registry_key('HKLM\Software\Policies\Microsoft\Windows Defender').with(
          'ensure' => 'present',
        )
      }

      it {
        is_expected.to contain_registry_key('HKLM\Software\Policies\Microsoft\Windows Defender\Scan').with(
          'ensure' => 'present',
        )
      }

      it {
        is_expected.to contain_registry_key('HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration').with(
          'ensure' => 'present',
        )
      }

      context 'with default settings' do
        it {
          is_expected.to contain_registry_value('HKLM\Software\Policies\Microsoft\Windows Defender\DisableAntiSpyware').with(
            'ensure' => 'present',
            'type'   => 'dword',
            'data'   => '1',
          )
        }

        it {
          is_expected.to contain_registry_value('HKLM\Software\Policies\Microsoft\Windows Defender\Scan\CheckForSignaturesBeforeRunningScan').with(
            'ensure' => 'present',
            'type'   => 'dword',
            'data'   => '1',
          )
        }

        it {
          is_expected.to contain_registry_value('HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration\UILockdown').with(
            'ensure' => 'present',
            'type'   => 'dword',
            'data'   => '0',
          )
        }
      end

      context 'with `allow_disabling` set to false' do
        let(:params) { { allow_disabling: false } }

        it {
          is_expected.to contain_registry_value('HKLM\Software\Policies\Microsoft\Windows Defender\DisableAntiSpyware').with(
            'ensure' => 'present',
            'type'   => 'dword',
            'data'   => '0',
          )
        }
      end

      context 'with `update_before_scan` set to false' do
        let(:params) { { update_before_scan: false } }

        it {
          is_expected.to contain_registry_value('HKLM\Software\Policies\Microsoft\Windows Defender\Scan\CheckForSignaturesBeforeRunningScan').with(
            'ensure' => 'present',
            'type'   => 'dword',
            'data'   => '0',
          )
        }
      end

      context 'with `ui_lockdown` set to true' do
        let(:params) { { ui_lockdown: true } }

        it {
          is_expected.to contain_registry_value('HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration\UILockdown').with(
            'ensure' => 'present',
            'type'   => 'dword',
            'data'   => '1',
          )
        }
      end

      context 'with `purge_exclusions` set to true' do
        let(:params) { { purge_exclusions: true } }

        it {
          is_expected.to contain_registry_key('HKLM\Software\Policies\Microsoft\Windows Defender\Exclusions').with(
            'ensure' => 'absent',
          )
        }
      end
    end
  end
end
