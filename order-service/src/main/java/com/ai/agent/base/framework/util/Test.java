package com.ai.agent.base.framework.util;

public class Test {
    public static void main(String[] args) {
        // 传入指定的机器ID和数据中心ID
        SnowflakeIdWorker idWorker = new SnowflakeIdWorker(1, 1);

        for (int i = 0; i < 10; i++) {
            long id = idWorker.nextId();
            System.out.println(Long.toBinaryString(id)); // 查看二进制结构
            System.out.println(id);
        }
    }
}
