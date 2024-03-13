import pyautogui
import os
import time
import pygetwindow
from datetime import datetime
# import schedule

# Primeiro roda a Posicao Mouse para localizar a posicao (precisa ser feito a primeira vez manual)
'''
def posicao_mouse():
    print("Mova o mouse para o local desejado e aguarde alguns segundos...")
    posicao = pyautogui.position()
    print(f"A posição do mouse é: {posicao}")
'''
# Informando as posições X e Y da tela, para os botões "Dados", "Atualizar Tudo" e "Salvar" do Excel. E armazenando em variavel.
posicao_dados = pyautogui.position(x=484, y=47)
posicao_atualizar = pyautogui.position(x=364, y=93)
posicao_salvar = pyautogui.position(x=874, y=553)

print(f'Inicio da atualização as {datetime.now()}')

def atualizar_excel(posicao_dados, posicao_atualizar):
    # Caminho para o arquivo Excel
    caminho_arquivo = r"G:\Comum\Administrativo\CONCILIAÇÕES\FIDC\FIDC - Red Asset Real\Posição Diária\Posicao Diaria Composicao Carteira - REAL.xlsx"

    # Abrindo o arquivo.
    os.startfile(caminho_arquivo)

    # Tempo (em seg) de espera para o Excel abrir (Tempo pode variar dependendo da velocidade do seu sistema)
    time.sleep(10)

    # Clique na guia Dados
    pyautogui.click(posicao_dados[0], posicao_dados[1])

    # Tempo aguardando a Guia Dados abrir
    time.sleep(2)

    # Clique no botão "Atualizar Tudo"
    pyautogui.click(posicao_atualizar[0], posicao_atualizar[1])

    # Tempo de Atualizacao 
    time.sleep(600)

    # Fechar o Excel
    pyautogui.hotkey('alt', 'f4')

    time.sleep(10) # Tempo aguardando aparecer a janela para SALVAR

    # Salvar apertando ENTER
    pyautogui.hotkey('enter')    
    #pyautogui.click(posicao_salvar[0], posicao_salvar[1])

    print(f'Arquivo atualizado as == {datetime.now()}')

# Chamar a função para atualizar o Excel
atualizar_excel(posicao_dados, posicao_atualizar)