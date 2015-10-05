PHPTranslationFestBrasil-VM
===========================

Uma máquina virtual Vagrant com o Lubuntu e todos os requisitos instalados para
fazer a tradução do manual do PHP.

## Requisitos
 - [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
 - [VirtualBox 5.0 Oracle VM VirtualBox Extension Pack](http://download.virtualbox.org/virtualbox/5.0.0/Oracle_VM_VirtualBox_Extension_Pack-5.0.0-101573.vbox-extpack)
 - [Vagrant](http://www.vagrantup.com/downloads.html)

## Começando

### VM de 32 ou 64 bits?

Você tem a escolha de usar uma máquina virtual de 32 ou 64 bits.

É só editar o `Vagrantfile` e alterar a seguinte linha:

```ruby
# Set the BOX (32 OR 64 BITS) you'd like to use
WHICH_BOX = BOX_32BITS # para 32 bits

# ou

WHICH_BOX = BOX_64BITS # para 64 bits
```

Depois disso, é só iniciar o ambiente:

```bash
$ vagrant up
```

