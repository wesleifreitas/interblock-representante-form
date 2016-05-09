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
      url: 'custom/representante/representante.cfc?method=saveData',
      params: params
    }).success(function(response) {
      callback(response);
    }).
    error(function(data, status, headers, config) {
      // Erro
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
      operacao: 0,
      autorizado: false
    };

    $scope.cliente = {
      bairro: 'bairro',
      cidade: 'cidade',
      complemento: 'complemento',
      cpfCnpj: 'cpf',
      email: 'e-mail',
      endereco: 'endereço',
      nascimento: new Date(),
      nome: 'nome',
      rgInscricaoEstadual: 'rg',
      tel1: 'telefone residencial',
      tel2: 'telefone comercial',
      tel3: 'telefone celular',
      tipo: 'F',
      uf: 'uf'
    };

    $scope.veiculo = {
      ano: 'ano',
      cor: 'cor',
      modelo: 'modelo',
      placa: 'placa'
    };

    $scope.equipamentos = [{
      nome: 'BLOQUEADOR AUTOMÁTICO',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00'
    }, {
      nome: 'RASTREADOR GSM/GPS 2000',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00'
    }, {
      nome: 'RASTREADOR GSM/GPS 3000',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00'
    }, {
      nome: 'BATERIA AUXILIAR',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00'
    }, {
      nome: 'ELETROVÁLVULA',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00'
    }, {
      nome: 'SENSOR DE PORTA',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00'
    }, {
      nome: 'MÓDULO DE VIDRO',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00'
    }];

    $scope.servicos = [{
      nome: 'INSTALAÇÃO E REGISTRO DE CONTRATO',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00',
      comodato: false
    }, {
      nome: 'TAXA DE HABILITAÇÃO',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00',
      comodato: false
    }, {
      nome: 'SERVIÇOS DE CENTRAL',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00',
      comodato: false
    }, {
      nome: 'LOCALIZADOR VIVA VOZ',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00',
      comodato: true
    }, {
      nome: 'CRÉDITO MENSAL CHIPS DE TELEMETRIA',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00',
      comodato: false
    }, {
      nome: 'CUSTO ADMINISTRATIVOS',
      valorVista: '0,00',
      pagamentroPrazo: '0',
      locacao: '0,00',
      comodato: false
    }];

    $scope.pagamento = {
      entrada: '0,00',
      nParcelas: 'n parcela',
      nParcelasEntrada: 'n parcela entrada',
      nValorParcelaEntrada: 'valor parcela entrada',
      tipo: 'dinheiro',
      valorParcela: 'valor parcela'
    };

    $scope.contrato = {
      dataInstalacao: new Date(),
      dataInicio: new Date(),
      dataTermino: new Date(),
      dataRenovacao: new Date()
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
    alert('Funcionalidade em desenvolvimento');
    var params = {
      representante: $scope.representante
    };
    formService.getData(params, function(response) {
      console.info('response', response);
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
    formService.saveData(params, function(response) {
      console.info('response', response);
      $timeout(function() {
        $scope.representanteForm.message = response.message;
        $scope.representanteForm.loading = false;
      }, 1500)
    });
  }
}])
console.info('app.js done');