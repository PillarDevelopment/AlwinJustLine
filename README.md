# AlwinJustLine

Rinkeby
[ERC20 Token](https://rinkeby.etherscan.io/address/0x8c1168ceba24fa5f7f7fe40f4ade96eb8635a543#code)

[PriceController](https://rinkeby.etherscan.io/address/0x596194d61aa3a54d0a52d6db50f196faebf3a4dc#readContract)

[AllWin Line Main Logic](https://rinkeby.etherscan.io/address/0x5e96a715c51c1ee9bc7c08ad417def9ef62886dc)


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