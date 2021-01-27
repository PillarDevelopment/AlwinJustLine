# AlwinJustLine

Rinkeby
[ERC20 Token](https://rinkeby.etherscan.io/address/0x9497271d070c3fa79a4d6ca58ee22bec6f65d04c#code)

[PriceController](https://rinkeby.etherscan.io/address/0xaf2afd9e832ca39dd9d88b7033ccbbb51eb5c141#readContract)

[AllWin Line Main Logic](https://rinkeby.etherscan.io/address/0x23212bc946454e7d88d28e63f26ff9ab49d7528e#code)


1) Деплой AllWin

2) Деплой PriceController

3) Добавить токены 
   
"0" - ETH

   "1" - AllWin

   "2" - USDT
   
Цена токена - сколько wei токена за 1 цент USD

4) Деплой AllWIn

5) AllWin.approveTokenForContract(router)

6) Token.Approve(Contract)

###AllWin.sol

```depositETH(address)``` - внести депозит в ETH;

```depositToken(amount, tokenId, upLiner)``` - внести депозит в токенах - перед этим отправитель должен заапрувить контракт AllWin.sol для отправляемого токена (token.approve(AllWinContract));

```withdraw()``` - вывести накопленные средства;

```maxPayoutOf(amount)``` - получить максимально возможный вывод;

```payoutOf(address)``` - возвращает сумму вывода и максимальный вывод;

```approveTokenForRouter()``` - метод апрува токена контрактом для Uniswap.Router - технический метод;

```getAdmin``` - получить адрес админа - только owner;

###PriceController.sol

```priceProvider``` - адрес поставщика информации о ценах;

```allWinToken``` - адрес AllWin токена;

```addNewToken(newPrice, tokenAddress)``` - добавить в массив новый токен для пополнения контракта AllWin.sol;

```updateTokenUSDRate(tokenId, newPrice)``` - обновить информацию цены токена;

```setPriceProvider(address)``` - добавить новый адрес поставщика информации о ценах;

```getAvailableTokenAddress(TokenId)``` - возвращает адрес токена по id;

```getTokenUSDRate(TokenId)``` - возвращает текущую цену в wei 1 цента по id (0 - ETH/wETH, 1- USDT);


Deploy - 3,503,030
Approve -160
Deploy 575,639
AddToken - 104000
Update token - 42*3
deploy - 1200000
105000 - transfer token
