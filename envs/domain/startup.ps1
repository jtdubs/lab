Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"

vagrant up dc --no-provision
vagrant snapshot save dc initial
vagrant provision dc --provision-with=windows-sysprep
vagrant snapshot save dc sysprep
vagrant provision dc --provision-with=forest,dc,share,ca,users,kds
vagrant snapshot save dc ready

vagrant up web --no-provision
vagrant snapshot save web initial
vagrant provision web --provision-with=windows-sysprep
vagrant snapshot save web sysprep
vagrant provision web --provision-with=join
vagrant snapshot save web ready

vagrant up user --no-provision
vagrant snapshot save user initial
vagrant provision user --provision-with=windows-sysprep
vagrant snapshot save user sysprep
vagrant provision user --provision-with=join
vagrant snapshot save user ready

vagrant up dev --no-provision
vagrant snapshot save dev initial
vagrant provision dev --provision-with=join
vagrant snapshot save dev ready

vagrant up hacker --no-provision
vagrant snapshot save hacker initial
vagrant provision hacker --provision-with=setup
vagrant snapshot save hacker ready