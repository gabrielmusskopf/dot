# Dot

Repositório com minhas configurações

## Quickstart

As configurações são gerenciadas utilizando [GNU Stow](https://www.gnu.org/software/stow/). Para inicializar:

```shell
git clone git@github.com:gabrielmusskopf/dot.git $HOME/dot
cd dot
```

É importante que seja clonado no diretório raiz do usuário, já que o `stow` cria symlinks no diretório pai com a mesma estrutura do diretório atual. Ou seja, esse diretório de configurações contém uma replica do diretório raiz do usuário, somente com as configurações gerenciadas.

Após clonado, crie os symlinks:

```shell
sudo apt install stow
# No diretório clonado "dot"
stow --adopt .
```

Recomendo ter os arquivos originais armazenado em outro lugar, ou versionados, já que `--adopt` irá sobrescrevê-los com o link simbólico.
