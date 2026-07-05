Name:           runningbar-plymouth
Version:        1.0.0
Release:        1%{?dist}
Summary:        Minimal running bar Plymouth boot splash theme

License:        MIT
URL:            https://example.invalid/runningbar-plymouth
BuildArch:      noarch

Source0:        runningbar-plymouth-%{version}.tar.gz

Requires:       plymouth

%description
Running Bar is a minimal Plymouth boot splash theme.

%prep
%autosetup -n runningbar-plymouth-%{version}

%build

%install
install -d %{buildroot}%{_datadir}/plymouth/themes/runningbar
install -m 0644 plymouth/runningbar/runningbar.plymouth %{buildroot}%{_datadir}/plymouth/themes/runningbar/runningbar.plymouth
install -m 0644 plymouth/runningbar/runningbar.script %{buildroot}%{_datadir}/plymouth/themes/runningbar/runningbar.script

%files
%license LICENSE
%doc README-plymouth.md
%{_datadir}/plymouth/themes/runningbar/runningbar.plymouth
%{_datadir}/plymouth/themes/runningbar/runningbar.script

%changelog
* Sun Jul 05 2026 GitHub Copilot <copilot@example.invalid> - 1.0.0-1
- Initial package