<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Angular Material style sheet -->
    <link rel="stylesheet" href="lib/angular-material/angular-material.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>

<body ng-app="angularApp" ng-cloak layout="column">
    <md-content layout="row" layout-align="center center" ng-controller="FormCtrl" ng-init="init()">
        <div flex="70" flex-sm="100">
            <div layout="column" ng-cloak class="md-inline-form">
                <md-content layout-gt-sm="row">
                    <md-toolbar class="md-hue-2">
                        <div class="md-toolbar-tools">
                            <h2>
                        <span>Representante INTERBLOCK</span>
                    </h2>
                            <span flex></span>
                            <md-button class="md-icon-button" aria-label="More">
                                <md-icon class="material-icons">more_vert</md-icon>
                            </md-button>
                        </div>
                    </md-toolbar>
                </md-content>
                <!-- <md-content layout-padding style="background-color: #fff"> -->
                <!-- style para teste.-->
                <div layout-padding class="div-form">
                    <center>
                        <h3>Representate</h3>
                    </center>
                    <form name="loginForm" layout-gt-xs="row">
                        <md-input-container class="md-block" flex-gt-xs>
                            <label>Representante</label>
                            <input ng-model="representante.nome" ng-disabled="representante.autorizado" required ng-keypress="loginTry($event)">
                        </md-input-container>
                        <md-input-container class="md-block" flex-gt-xs>
                            <label>Senha do representante</label>
                            <input ng-model="representante.senha" type="password" ng-disabled="representante.autorizado" required ng-keypress="loginTry($event)">
                        </md-input-container>
                        <md-input-container class="md-block" flex-gt-xs>
                            <label>Vendedor</label>
                            <input ng-model="representante.vendedor" required>
                        </md-input-container>
                        <md-input-container class="md-block md-input-has-placeholder" flex-gt-xs>
                            <label>Código da operação</label>
                            <input ng-model="representante.operacao" ng-disabled="representante.autorizado" type="number" required ng-keypress="loginTry($event)">
                            <div class="operacao-hint">
                                <span>Preencha com 0 (zero) para uma nova operação ou digite outro número para consultar operação já salva.</span>
                            </div>
                        </md-input-container>
                    </form>
                    <md-content layout="row" layout-align="center center">
                        <md-button class="md-raised md-primary" ng-click="login()" ng-disabled="loginForm.$invalid === true || loginForm.loading" ng-show="representante.operacao == 0 && !representante.autorizado">
                            <md-icon class="material-icons">assignment</md-icon>
                            Iniciar preenchimento
                        </md-button>
                        <md-button class="md-raised md-primary" ng-click="getData()" ng-disabled="loginForm.$invalid === true || loginForm.loading" ng-show="representante.operacao != 0 && !representante.autorizado">
                            <md-icon class="material-icons">search</md-icon>
                            Consultar dados
                        </md-button>
                        <md-button class="md-raised md-primary" ng-click="restart()" ng-disabled="loginForm.$invalid === true || loginForm.loading" ng-show="representante.autorizado">
                            <md-icon class="material-icons">restore_page</md-icon>
                            Reiniciar formulário
                        </md-button>
                    </md-content>
                    <div class="error">{{loginForm.message}}</div>
                    <md-progress-linear md-mode="indeterminate" ng-show="loginForm.loading"></md-progress-linear>
                    <form name="representanteForm" ng-show="representante.autorizado">
                        <center>
                            <h3>Cliente</h3>
                        </center>
                        <div layout-gt-xs="row">
                            <md-input-container class="md-block" flex-gt-xs>
                                <label>Nome / Razão Social</label>
                                <input name="clienteNome" ng-model="cliente.rev_cli_nome" required>
                                <div ng-messages="representanteForm.clienteNome.$error">
                                    <div ng-message="required">Campo obrigatório.</div>
                                </div>
                            </md-input-container>
                            <div layout="column" class="datepicker-column">
                                <label>Dt. Nascimento</label>
                                <md-datepicker name="clienteNascimento" ng-model="cliente.rev_cli_nascimento" md-placeholder="" required>
                                </md-datepicker>                              
                                <!--
                                <div ng-show="representanteForm.clienteNascimento.$error.required && representanteForm.clienteNascimento.$error.valid === false">Data obrigatória.</div>
                                <div ng-show="representanteForm.clienteNascimento.$error.valid">Data inválida. <span class="hint">DD/MM/AAAA</span></div>
                                -->
                                <span class="hint">DD/MM/AAAA</span>                                
                            </div>
                        </div>
                        <div layout-gt-sm="row">
                            <md-input-container class="md-block md-input-has-placeholder" flex="20">
                                <label>CEP</label>
                                <input ng-model="cliente.rev_cli_cep" ui-mask="99999-999">
                            </md-input-container>
                            <md-input-container class="md-block" flex="50">
                                <label>Endereço</label>
                                <input ng-model="cliente.rev_cli_endereco">
                            </md-input-container>
                            <!--
                            <md-input-container class="md-block" flex="10">
                                <label>N°</label>
                                <input ng-model="cliente.rev_cli_endereco_numero">
                            </md-input-container>
                            -->
                            <md-input-container class="md-block" flex-gt-sm>
                                <label>Complemento</label>
                                <input ng-model="cliente.rev_cli_complemento">
                            </md-input-container>
                        </div>
                        <div layout-gt-sm="row">
                            <md-input-container class="md-block" flex="40">
                                <label>Bairro</label>
                                <input ng-model="cliente.rev_cli_bairro">
                            </md-input-container>
                            <md-input-container class="md-block" flex="40">
                                <label>Cidade</label>
                                <input ng-model="cliente.rev_cli_cidade">
                            </md-input-container>
                            <md-input-container class="md-block" flex="20">
                                <label>UF</label>
                                <input ng-model="cliente.rev_cli_uf">
                            </md-input-container>
                        </div>
                        <div layout-gt-sm="row">
                            <md-input-container class="md-block" flex="35">
                                <label>Telefone Residencial</label>
                                <input ng-model="cliente.rev_cli_tel1">
                            </md-input-container>
                            <md-input-container class="md-block" flex="35">
                                <label>Telefone Comercial</label>
                                <input ng-model="cliente.rev_cli_tel2">
                            </md-input-container>
                            <md-input-container class="md-block" flex="35">
                                <label>Telefone Celular</label>
                                <input ng-model="cliente.rev_cli_tel3">
                            </md-input-container>
                        </div>
                        <div layout-gt-sm="row">
                            <md-radio-group ng-model="cliente.rev_cli_pessoa" flex="35" ng-change="rev_cli_pessoaChange($event)">
                                <md-radio-button value="F" class="md-primary">Física</md-radio-button>
                                <md-radio-button value="J" class="md-primary">Jurídica</md-radio-button>
                            </md-radio-group>
                            <md-input-container class="md-block md-input-has-placeholder" flex="35">
                                <label>{{rev_cli_pessoa_label}}</label>
                                <input ng-model="cliente.rev_cli_cpfCnpj" ui-mask="{{rev_cli_pessoa_mask}}">
                            </md-input-container>
                            <md-input-container class="md-block md-input-has-placeholder" flex="35">
                                <label>{{rev_cli_rgInscricaoEstadual_label}}</label>
                                <input ng-model="cliente.rev_cli_rgInscricaoEstadual" ui-mask="{{rev_cli_rgInscricaoEstadual_mask}}">
                            </md-input-container>
                        </div>
                        <div layout-gt-sm="row">
                            <md-input-container class="md-block" flex="100">
                                <label>E-mail</label>
                                <input ng-model="cliente.rev_cli_email">
                            </md-input-container>
                        </div>
                        <center>
                            <h3>Véiculo</h3>
                        </center>
                        <div layout-gt-sm="row">
                            <md-input-container class="md-block" flex="55">
                                <label>Veículo (Marca/Modelo)</label>
                                <input ng-model="veiculo.rev_vei_modelo">
                            </md-input-container>
                            <md-input-container class="md-block" flex="15">
                                <label>Cor</label>
                                <input ng-model="veiculo.rev_vei_cor">
                            </md-input-container>
                            <md-input-container class="md-block" flex="15">
                                <label>Ano</label>
                                <input ng-model="veiculo.rev_vei_ano">
                            </md-input-container>
                            <md-input-container class="md-block" flex="15">
                                <label>Placa</label>
                                <input ng-model="veiculo.rev_vei_placa">
                            </md-input-container>
                        </div>
                        <center>
                            <h3>Equipamentos</h3>
                        </center>
                        <div layout-gt-sm="row" ng-repeat="equipamento in equipamentos">
                            <md-input-container class="md-block" flex="55">
                                <label>Equipamento</label>
                                <input ng-model="equipamento.nome" disabled="">
                            </md-input-container>
                            <md-input-container class="md-block" flex="15">
                                <label>Valor a vista</label>
                                <input ng-model="equipamento.valorVista.value">
                            </md-input-container>
                            <md-input-container class="md-block" flex="15">
                                <label>Pag. prazo</label>
                                <input ng-model="equipamento.pagamentoPrazo.value">
                            </md-input-container>
                            <md-input-container class="md-block" flex="15">
                                <label>Locação Mensal</label>
                                <input ng-model="equipamento.locacao.value">
                            </md-input-container>
                        </div>
                        <center>
                            <h3>Serviços</h3>
                        </center>
                        <div layout-gt-sm="row" ng-repeat="servico in servicos">
                            <md-input-container class="md-block" flex="55">
                                <label>Serviço</label>
                                <input ng-model="servico.nome" disabled="">
                            </md-input-container>
                            <md-input-container class="md-block" flex="15" ng-if="servico.comodato === false">
                                <label>Valor a vista</label>
                                <input ng-model="servico.valorVista.value">
                            </md-input-container>
                            <md-input-container class="md-block" flex="15" ng-if="servico.comodato === false">
                                <label>Pag. prazo</label>
                                <input ng-model="servico.pagamentoPrazo.value">
                            </md-input-container>
                            <md-input-container class="md-block" flex="15" ng-if="servico.comodato === false">
                                <label>Locação Mensal</label>
                                <input ng-model="servico.locacao.value">
                            </md-input-container>
                            <md-input-container class="md-block" flex="15" ng-if="servico.comodato === true">
                                <label></label>
                                <label>COMOTADO</label>
                            </md-input-container>
                        </div>
                        <center>
                            <h3>Condições de pagamento</h3>
                        </center>
                        <div layout-gt-sm="row">
                            <md-radio-group ng-model="pagamento.rev_pagamento_tipo">
                                <md-radio-button value="D" class="md-primary">Dinheiro</md-radio-button>
                                <md-radio-button value="B" class="md-primary">Boleto</md-radio-button>
                                <md-radio-button value="C" class="md-primary">Cheque</md-radio-button>
                            </md-radio-group>
                            <md-input-container class="md-block" flex="80">
                                <label>Entrada</label>
                                <input ng-model="pagamento.rev_pagamento_entrada">
                            </md-input-container>
                            <md-input-container class="md-block" flex="35">
                                <label>N° de parcelas da entrada</label>
                                <input ng-model="pagamento.rev_pagamento_entrada_n_parcelas">
                            </md-input-container>
                            <md-input-container class="md-block" flex="35">
                                <label>Valor por parcelas da entrada</label>
                                <input ng-model="pagamento.rev_pagamento_entrada_valor_parcela">
                            </md-input-container>
                        </div>
                        <div layout-gt-sm="row" ng-if="pagamento.rev_pagamento_tipo == 'C'">
                            <md-input-container class="md-block" flex="35">
                                <label>Banco</label>
                                <input ng-model="pagamento.rev_pagamento_banco" required="{{pagamento.rev_pagamento_tipo === 'C'}}">
                            </md-input-container>
                            <md-input-container class="md-block" flex="35">
                                <label>Numeração dos cheques</label>
                                <input ng-model="pagamento.rev_pagamento_cheque_numeracao" required="{{pagamento.rev_pagamento_tipo === 'C'}}">
                            </md-input-container>
                            <md-datepicker ng-model="pagamento.rev_pagamento_cheque_data_inicio" md-placeholder="1° vencimento" required="{{pagamento.rev_pagamento_tipo === 'C'}}">
                            </md-datepicker>
                        </div>
                        <center>
                            <h4>Assumindo ainda</h4>
                        </center>
                        <div layout-gt-sm="row">
                            <md-input-container class="md-block" flex="35">
                                <label>N° de parcelas</label>
                                <input ng-model="pagamento.rev_pagamento_n_parcelas">
                            </md-input-container>
                            <md-input-container class="md-block" flex="35">
                                <label>Valor de cada parcela</label>
                                <input ng-model="pagamento.rev_pagamento_valor_parcela">
                            </md-input-container>
                        </div>
                        <center>
                            <h3>Vigência do contrato</h3>                  
                        </center>
                        <div layout-gt-sm="row">
                            <div layout="column" class="datepicker-column">
                                <label>Dt. de Instalação</label>
                                <md-datepicker ng-model="contrato.rev_con_data_instalacao" md-placeholder="" required>
                                </md-datepicker>
                                <span class="hint">DD/MM/AAAA</span>
                            </div>
                            <div layout="column" class="datepicker-column">
                                <label>Dt. Início do contrato</label>
                                <md-datepicker ng-model="contrato.rev_con_data_inicio" md-placeholder="" required ng-change="contratoInicio()">
                                </md-datepicker>
                                <span class="hint">DD/MM/AAAA</span>
                             </div>
                            <div layout="column" class="datepicker-column">
                                <label>Dt. Término do contrato</label>
                                <md-datepicker name="rev_con_data_fim" ng-model="contrato.rev_con_data_fim" md-placeholder="" required>
                                </md-datepicker>
                                <span class="hint">DD/MM/AAAA</span>
                            </div>
                            <div layout="column" class="datepicker-column">
                                <label>Dt. Renovação do contrato</label>
                                <md-datepicker ng-model="contrato.rev_con_data_renovacao" md-placeholder="" required>
                                </md-datepicker>
                                <span class="hint">DD/MM/AAAA</span>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- </md-content> -->
            </div>
            <md-content ng-show="representante.autorizado" layout="row" layout-sm="column" layout-align="center center" layout-wrap>
                <div layout="column">
                    <md-button class="md-raised md-primary" ng-click="saveData()" ng-disabled="getDisabled(representanteForm)">
                        <md-icon class="material-icons">picture_as_pdf</md-icon>
                        Salvar e gerar PDF
                    </md-button>                
                    <md-checkbox class="md-primary" ng-model="representante.enviarEmail" aria-label="Enviar e-mail">
                        Enviar e-mail para a Interblock
                    </md-checkbox>
                <div>
                <md-progress-linear md-mode="indeterminate" ng-show="representanteForm.loading"></md-progress-linear>
                <!--
                    <md-button class="md-raised md-primary">
                        <md-icon class="material-icons">email</md-icon>
                        Enviar dados para INTERBLOCK
                    </md-button>
                    -->
            </md-content>
            <div class="error">{{representanteForm.message}}</div>
        </div>
    </md-content>
    <!-- Angular Material requires Angular.js Libraries -->
    <script src="lib/angular/angular.min.js"></script>
    <script src="lib/angular-animate/angular-animate.min.js"></script>
    <script src="lib/angular-aria/angular-aria.min.js"></script>
    <script src="lib/angular-messages/angular-messages.min.js"></script>
    <!-- Angular Material Library -->
    <script src="lib/angular-material/angular-material.min.js"></script>
    <!-- Angular Route Library -->
    <script src="lib/angular-route/angular-route.min.js"></script>
    <!-- Moment.js -->
    <script src="lib/moment/min/moment-with-locales.min.js"></script>
    <!-- Angular ui-mask -->
    <script src="lib/angular-ui-mask/dist/mask.min.js"></script>
    <!-- Angular App -->
    <script src="js/app.js"></script>
</body>

</html>
