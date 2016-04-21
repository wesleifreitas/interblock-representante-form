console.info('app.js init');
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

  // https://material.angularjs.org/latest/api/service/$mdDateLocaleProvider
  $mdDateLocaleProvider.months = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'];
  $mdDateLocaleProvider.shortMonths = ['jan.', 'fev', 'mar', 'abr', 'maio', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];

}]);

app.controller('FormCtrl', function($scope) {
  $scope.user = {
    uf: 'SP'
  };
  /*
  $scope.states = ('AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS ' +
  	'MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI ' +
  	'WY').split(' ').map(function(state) {
  	return {
  		abbrev: state
  	};
  });
  */
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
  }]

  $scope.pagamento = {
    tipo: 'dinheiro',
    entrada: '0,00',
    nParcelasEntrada: 1
  }
})
console.info('app.js done');