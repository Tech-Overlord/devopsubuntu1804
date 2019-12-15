#!/bin/bash -e

# Shellcheck fixes for: SC2181

package="awscli"
simple_pkg="aws"

check_os () {
  if [ "$(grep -Ei 'VERSION_ID="16.04"' /etc/os-release)" ];
  then
    echo -e "\nSystem OS is Ubuntu. Version is 16.04.\n\n###\tProceeding with SCRIPT Execution\t###\n"
  elif [ "$(grep -Ei 'VERSION_ID="18.04"' /etc/os-release)" ];
  then
    echo -e "\nSystem OS is Ubuntu. Version is 18.04.\n\n###\tProceeding with SCRIPT Execution\t###\n"
  else
    echo -e "\nThis is neither Ubuntu 16.04 or Ubuntu 18.04.\n\n###\tScript execution HALTING!\t###\n"
    exit 2
  fi
}

check_if_pip3_installed () {
  if python3 -m pip --version &> /dev/null;
    then
      echo -e "\nYES: pip3 is IN an installed state within the system.\n"
    else
      echo -e "\nNO: pip3 is NOT IN an installed state.\n"
  fi
}

check_if_awscli_installed () {
  if ${simple_pkg} --version &> /dev/null;
    then
      echo -e "\nYES: ${package} is IN an installed state within the system.\n"
      exit 0
    else
      echo -e "\nNO: ${package} is NOT IN an installed state.\n"
  fi
}

awscli_installer () {
  python3 -m pip install ${package}
}

awscli_upgrade () {
  python3 -m pip install -U ${package}
}

awscli_uninstaller () {
  python3 -m pip uninstall ${package} -y
}

case "$1" in
  check)
    check_os
		check_if_pip3_installed
    check_if_awscli_installed
    ;;
  install)
    check_os
		check_if_pip3_installed
    check_if_awscli_installed
    echo -e "\nInstallation beginning for:\t${package}\n"
    awscli_installer
    ;;
  upgrade)
    check_os
		check_if_pip3_installed
    awscli_upgrade
    ;;
  uninstall)
    check_os
		check_if_pip3_installed
    echo -e "\nPurging beginning for:\t${package}\n"
    awscli_uninstaller
    ;;
  *)
    echo -e $"\nUsage:\t $0 check\t\t\t : Checks if ${package} is installed on the system."
    echo -e $"Usage:\t $0 install\t\t : For installing ${package} from the system."
    echo -e $"Usage:\t $0 upgrade\t\t : For upgrading pip3 from the system."
    echo -e $"Usage:\t $0 uninstall\t\t : For uninstalling/purging ${package} from the system.\n"
    exit 1
esac