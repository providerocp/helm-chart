## Motivação

Pacotes Helm são uma forma eficiente de gerenciar aplicações no Kubernetes.  
Com Helm, é possível empacotar, versionar e distribuir aplicações de maneira padronizada, facilitando a instalação e atualização.  

Ele permite reutilizar configurações, automatizar implantações e garantir consistência entre ambientes.  
Além disso, simplifica a gestão de dependências e torna o processo de manutenção mais ágil e seguro.  


## Configuração

A entrega do pacote helm OCI é realizada diretamente no projeto shared na conta da GCP.  
O mesmo deve ser versionado seguindo o padrão SemVer.  

## Importante
* Sempre valide suas mudanças com helm template
* Não esqueça de incrementar sua versão
* Escrever um commit claro da mudança

## Como implementar (GCP)

Após mudanças, subi versão no Chart.yaml e subi o código para a pipeline publicar a nova versão.


## Como implementar GITHUB

Validar pacote:
helm template charts/basic-app

Gerar pacote:
helm package charts/basic-app

Prepara pacote:
helm repo index --url https://providerocp.github.io/helm-chart .

