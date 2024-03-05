import os
import pyautogui
import time

# Descobrir as posições X e Y para os botões "Dados" e "Atualizar Tudo"
posicao_dados = pyautogui.position(x=484, y=47) #descobrir_posicao({x=484, y=47})
# print(f"Posição dos botões 'Dados': {posicao_dados}")
posicao_atualizar = pyautogui.position(x=364, y=93) # descobrir_posicao()
# print(f"Posição dos botões 'Atualizar Tudo': {posicao_atualizar}")

def atualizar_excel(posicao_dados, posicao_atualizar):
    # Caminho para o arquivo Excel
    caminho_arquivo = r"G:\Comum\Administrativo\CONCILIAÇÕES\FIDC\FIDC - Red Asset Real\Posição Diária\Posicao Diaria Composicao Carteira - REAL.xlsx"

    # Abrir o Excel
    os.startfile(caminho_arquivo)

    # Esperar o Excel abrir
    time.sleep(20)  # Tempo pode variar dependendo da velocidade do seu sistema

    # Simular clique na guia Dados
    # pyautogui.click(posicao_dados[0], posicao_dados[1])
    pyautogui.click(484, 47)

    # Esperar a guia "Dados" abrir
    time.sleep(2)

    # Simular clique no botão "Atualizar Tudo"
    # pyautogui.click(posicao_atualizar[0], posicao_atualizar[1])
    pyautogui.click(364, 93)

    # Esperar a atualização terminar
    time.sleep(600)  # Esperar 8 minutos

    # Fechar o Excel
    pyautogui.hotkey('alt', 'f4')

# Chamar a função para atualizar o Excel
atualizar_excel(posicao_dados, posicao_atualizar)

