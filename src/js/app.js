console.info('app.js init');

var config = {
  dsn: 'px_interblock_sql_local'
}
var app = angular.module('angularApp', ['ngAria', 'ngMaterial', 'ngRoute'], function() {});

app.config(['$routeProvider', '$locationProvider', '$mdThemingProvider', '$mdDateLocaleProvider', function($routeProvider, $locationProvider, $mdThemingProvider, $mdDateLocaleProvider) {

  $routeProvider.when('/other', {
    templateUrl: 'other/other.html',
    controller: 'otherCtrl',
    controllerAs: 'vm'
  });

  $routeProvider.otherwise({
    redirectTo: '/'
  });

  moment.locale('pt-br');
  // https://material.angularjs.org/latest/api/service/$mdDateLocaleProvider
  $mdDateLocaleProvider.months = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  $mdDateLocaleProvider.shortMonths = ['jan.', 'fev', 'mar', 'abr', 'maio', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
  $mdDateLocaleProvider.parseDate = function(dateString) {
    //moment.locale('pt-br');
    var m = moment(dateString, 'L', true);
    return m.isValid() ? m.toDate() : new Date(NaN);
  };
  $mdDateLocaleProvider.formatDate = function(date) {
    //moment.locale('pt-br');    
    if (moment(date).format('L') === 'Invalid date') return ''
    else return moment(date).format('L');
  };
}]);

app.factory('formService', ['$http', function($http) {

  var service = {};
  service.login = login;
  service.getData = getData;
  service.saveData = saveData;

  return service;

  function login(params, callback) {
    params.dsn = config.dsn;
    $http({
      method: 'POST',
      url: 'custom/representante/representante.cfc?method=login',
      params: params
    }).success(function(response) {
      callback(response);
    }).
    error(function(data, status, headers, config) {
      // Erro
      alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
    });
  }

  function getData(params, callback) {
    params.dsn = config.dsn;
    $http({
      method: 'POST',
      url: 'custom/representante/representante.cfc?method=getData',
      params: params
    }).success(function(response) {
      callback(response);
    }).
    error(function(data, status, headers, config) {
      // Erro
      alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
    });
  }

  function saveData(params, callback) {
    params.dsn = config.dsn;
    $http({
      method: 'POST',
      url: '../../rest/interblock-representante/service/form',
      data: params
    }).then(function successCallback(response) {
      callback(response);
    }, function errorCallback(response) {
      alert('Ops! Ocorreu um erro inesperado.\nPor favor contate o administrador do sistema!');
    });
  }

}]);


app.controller('FormCtrl', ['formService', '$scope', '$timeout', function(formService, $scope, $timeout) {

  /*
  $scope.states = ('AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS ' +
    'MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI ' +
    'WY').split(' ').map(function(state) {
    return {
      abbrev: state
    };
  });
  */
  $scope.init = function() {
    $scope.loginForm = {
      message: '',
      error: false,
      loading: false
    }

    $scope.representanteForm = {
      message: '',
      error: false,
      loading: false
    }

    $scope.representante = {
      nome: 'representante',
      senha: 'senha',
      vendedor: 'vendedor',
      operacao: 11606,
      autorizado: false
    };

    $scope.cliente = {
      rev_cli_bairro: 'bairro',
      rev_cli_cidade: 'cidade',
      rev_cli_complemento: 'complemento',
      rev_cli_cpfCnpj: 'cpf',
      rev_cli_email: 'e-mail',
      rev_cli_cep: 'cep',
      rev_cli_endereco: 'endereço',
      rev_cli_endereco_numero: '',
      rev_cli_nascimento: new Date(),
      rev_cli_nome: 'nome',
      rev_cli_rgInscricaoEstadual: 'rg',
      rev_cli_tel1: 'telefone residencial',
      rev_cli_tel2: 'telefone comercial',
      rev_cli_tel3: 'telefone celular',
      rev_cli_tel4: '',
      rev_cli_pessoa: 'F',
      rev_cli_uf: 'uf'
    };

    $scope.veiculo = {
      rev_vei_ano: 'ano',
      rev_vei_cor: 'cor',
      rev_vei_marca: '',
      rev_vei_modelo: 'modelo',
      rev_vei_placa: 'placa'
    };

    $scope.equipamentos = [{
      nome: 'BLOQUEADOR AUTOMÁTICO',
      valorVista: {
        field: 'rev_e_bloqueador_automatico_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_e_bloqueador_automatico_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_e_bloqueador_automatico_mensal',
        value: '0,00'
      },
    }, {
      nome: 'RASTREADOR GSM/GPS 2000',
      valorVista: {
        field: 'rev_e_rastreador_2000_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_e_rastreador_2000_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_e_rastreador_2000_mensal',
        value: '0,00'
      },
    }, {
      nome: 'RASTREADOR GSM/GPS 3000',
      valorVista: {
        field: 'rev_e_rastreador_3000_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_e_rastreador_3000_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_e_rastreador_3000_mensal',
        value: '0,00'
      },
    }, {
      nome: 'BATERIA AUXILIAR',
      valorVista: {
        field: 'rev_e_bateria_auxiliar_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_e_bateria_auxiliar_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_e_bateria_auxiliar_mensal',
        value: '0,00'
      },
    }, {
      nome: 'ELETROVÁLVULA',
      valorVista: {
        field: 'rev_e_eletrovalvula_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_e_eletrovalvula_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_e_eletrovalvula_mensal',
        value: '0,00'
      },
    }, {
      nome: 'SENSOR DE PORTA',
      valorVista: {
        field: 'rev_e_sensor_porta_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_e_sensor_porta_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_e_sensor_porta_mensal',
        value: '0,00'
      },
    }, {
      nome: 'MÓDULO DE VIDRO',
      valorVista: {
        field: 'rev_e_modulo_vidro_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_e_modulo_vidro_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_e_modulo_vidro_mensal',
        value: '0,00'
      },
    }];

    $scope.servicos = [{
      nome: 'INSTALAÇÃO E REGISTRO DE CONTRATO',
      valorVista: {
        field: 'rev_s_instalacao_registro_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_s_instalacao_registro_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_s_instalacao_registro_mensal',
        value: '0,00'
      },
      comodato: false
    }, {
      nome: 'TAXA DE HABILITAÇÃO',
      valorVista: {
        field: 'rev_s_taxa_habilitacao_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_s_taxa_habilitacao_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_s_taxa_habilitacao_mensal',
        value: '0,00'
      },
      comodato: false
    }, {
      nome: 'SERVIÇOS DE CENTRAL',
      valorVista: {
        field: 'rev_s_central_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_s_central_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_s_central_mensal',
        value: '0,00'
      },
      comodato: false
    }, {
      nome: 'LOCALIZADOR VIVA VOZ',
      valorVista: {
        field: 'rev_s_viva_voz_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_s_viva_voz_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_s_viva_voz_mensal',
        value: '0,00'
      },
      comodato: true
    }, {
      nome: 'CRÉDITO MENSAL CHIPS DE TELEMETRIA',
      valorVista: {
        field: 'rev_s_credito_chip_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_s_credito_chip_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_s_credito_chip_mensal',
        value: '0,00'
      },
      comodato: false
    }, {
      nome: 'CUSTOS ADMINISTRATIVOS',
      valorVista: {
        field: 'rev_s_administrativo_vista',
        value: '0,00'
      },
      pagamentoPrazo: {
        field: 'rev_s_administrativo_prazo',
        value: '0,00'
      },
      locacao: {
        field: 'rev_s_administrativo_mensal',
        value: '0,00'
      },
      comodato: false
    }];

    $scope.pagamento = {
      rev_pagamento_entrada: '0,00',
      rev_pagamento_n_parcelas: 'n parcela',
      rev_pagamento_entrada_n_parcelas: 'n parcela entrada',
      rev_pagamento_entrada_valor_parcela: 'valor parcela entrada',
      rev_pagamento_tipo: 'D',
      rev_pagamento_valor_parcela: 'valor parcela',
      rev_pagamento_banco: '',
      rev_pagamento_cheque_numeracao: '',
      rev_pagamento_cheque_data_inicio: new Date()
    };

    $scope.contrato = {
      rev_con_data_instalacao: new Date(),
      rev_con_data_inicio: new Date(),
      rev_con_data_fim: new Date(),
      rev_con_data_renovacao: new Date()
    };
  }

  $scope.restart = function() {
    $scope.init();
  }

  $scope.login = function() {

    if ($scope.representante.nome === '' || $scope.representante.senha === '' || $scope.representante.vendedor === '' || $scope.representante.operacao === '') {
      return;
    }

    $scope.loginForm.loading = true;
    var params = {
      representante: $scope.representante
    };
    formService.login(params, function(response) {
      console.info('response', response);
      $timeout(function() {
        $scope.loginForm.error = !response.success;
        $scope.loginForm.message = response.message;
        $scope.representante.autorizado = response.autorizado;
        $scope.loginForm.loading = false;
      }, 1500);
    })
  }

  $scope.getData = function() {
    var params = {
      representante: $scope.representante
    };
    formService.getData(params, function(response) {
      console.info('response', response);
      if(response.qQuery.length === 0){
        alert('Nenhum registro encontrado');
        return;
      }
      $scope.representante.autorizado = true;

      // loop em cliente
      angular.forEach($scope.cliente, function(index, key) {
        if (key === 'rev_cli_nascimento') {
          $scope.cliente['rev_cli_nascimento'] = new Date(response.qQuery[0][key.toUpperCase()])
        } else {
          $scope.cliente[key] = response.qQuery[0][key.toUpperCase()];
        }
      });

      // loop em veículo
      angular.forEach($scope.veiculo, function(index, key) {
        $scope.veiculo[key] = response.qQuery[0][key.toUpperCase()];
      });

      // loop em equipamentos
      angular.forEach($scope.equipamentos, function(index) {
        index.valorVista.value = response.qQuery[0][index.valorVista.field.toUpperCase()];
        index.pagamentoPrazo.value = response.qQuery[0][index.pagamentoPrazo.field.toUpperCase()];
        index.locacao.value = response.qQuery[0][index.locacao.field.toUpperCase()];
      });

      // loop em servicos
      angular.forEach($scope.servicos, function(index) {
        index.valorVista.value = response.qQuery[0][index.valorVista.field.toUpperCase()];
        index.pagamentoPrazo.value = response.qQuery[0][index.pagamentoPrazo.field.toUpperCase()];
        index.locacao.value = response.qQuery[0][index.locacao.field.toUpperCase()];
      });

      // loop em pagamento
      angular.forEach($scope.pagamento, function(index, key) {
        if (key === 'rev_pagamento_cheque_data_inicio') {
          $scope.cliente['rev_pagamento_cheque_data_inicio'] = new Date(response.qQuery[0][key.toUpperCase()])
        } else {
          $scope.pagamento[key] = response.qQuery[0][key.toUpperCase()];
        }
      });

      // loop em contrato
      angular.forEach($scope.contrato, function(index, key) {
        $scope.contrato[key] = new Date(response.qQuery[0][key.toUpperCase()]);
      });
    })
  }

  $scope.saveData = function() {
    $scope.representanteForm.loading = true;
    var params = {
      representante: $scope.representante,
      cliente: $scope.cliente,
      veiculo: $scope.veiculo,
      equipamentos: angular.toJson($scope.equipamentos),
      servicos: angular.toJson($scope.servicos),
      pagamento: angular.toJson($scope.pagamento),
      contrato: $scope.contrato
    };

    //console.info('saveData', params);
    //return;
    formService.saveData(params, function(response) {
      console.info('response', response);

      $scope.representante.operacao = response.data.rev_codigo;
      window.open(
        '_server/files/venda_' + $scope.representante.operacao + '.pdf',
        '_blank'
      );

      $timeout(function() {
        $scope.representanteForm.message = response.data.message;
        $scope.representanteForm.loading = false;
      }, 1500)
    });
  }
}])
console.info('app.js done');