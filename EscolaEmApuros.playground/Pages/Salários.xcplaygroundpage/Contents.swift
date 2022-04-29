/*:
## Salários.
 
 Uma parte muito importante do sistema que irá gerenciar as escolas municipais é a parte que controla os salários.
 
 Como diria os Mamonas Assassinas:
 
 > *Money*.
 >
 > Que é *good* **nóis** *no have*.
 
 Você precisa ser capaz de realizar um somatório de salários.
 
 **[DESAFIO]** Como você realizaria o somatório abaixo?
 */

let primeiroSalario = 1000
let segundoSalario  = 2000
let terceiroSalario = 3000
let quartoSalario   = 2500

let somatorio = primeiroSalario + segundoSalario + terceiroSalario + quartoSalario

// A resposta esperada do somatório é 8500!

/*:

 Ótimo! Você aprendeu a realizar a soma através das variáveis!
 
 Porém, somar variáveis é um caso pouco provável de acontecer em um sistema com vários salários.
 
 É mais provável que você tenha acesso a uma lista (Array) de salários.
 
 **[DESAFIO]** Sendo assim, como você realizaria os somatórios abaixo?
 
 > Dica: Você pode usar um *for* para isso.
 */

// Somatório = 8500
let salarios1 = [1000, 2000, 3000, 2500]
var somatorioSalario1: Int = 0
var somatorioSalario2: Int = 0
var somatorioSalario3: Int = 0
var somatorioSalario4: Int = 0
var somatorioSalario5: Int = 0

for salario in salarios1{
    somatorioSalario1+=salario
}
print(somatorioSalario1)

// Somatório = 5010
let salarios2 = [3000, 1500, 500, 10]
for salario in salarios2{
    somatorioSalario2+=salario
}
print(somatorioSalario2)

// Somatório = 55500
let salarios3 = [8500, 10000, 13000, 24000]
for salario in salarios3{
    somatorioSalario3+=salario
}
print(somatorioSalario3)

// Somatório = 2500
let salarios4 = [2500]
for salario in salarios4{
    somatorioSalario4+=salario
}
print(somatorioSalario4)

// Somatório 71670
let salários5 = [1000, 200, 6000, 70, 4000, 100, 40000, 8000, 10000, 2300]
for salario in salários5{
    somatorioSalario5+=salario
}
print(somatorioSalario5)

/*:
Legal, mas... ninguém quer ficar repetindo todas essas linhas de código para realizar um somatório, não é mesmo?
 
 Que tal a gente transformar isso em uma *function*?
 
 **[DESAFIO]** Transformar o somatório em uma *function*!
 
 > Dica:
 >
 > Talvez você tenha algo como *func somatorioDeSalarios(salarios: [Double]) -> Double*.

*/

// Sua função aqui!
// Você pode usar as variáveis declaradas anteriormente!

func somatorioDeSalarios(salarios: [Double])->Double{
    var total: Double = 0.00
    for salario in salarios{
        total+=salario
    }
    return total
}

/*:
 Feito todos esses somatórios, é hora de avançarmos para a próxima lição!
 
 [Anterior: Introdução](@previous) | Página 2 de 6  |  [Na sequência: Cargos](@next)
 */
