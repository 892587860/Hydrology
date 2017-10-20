package com.hydro.model;

import java.util.Date;

public class TimingPackets {
    private String id;

    private String headRemoteAddress;

    private Date transmitTime;

    private String underWaterInstantDepth;

    private String instantWaterTemp;

    private String powerVoltage;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getHeadRemoteAddress() {
        return headRemoteAddress;
    }

    public void setHeadRemoteAddress(String headRemoteAddress) {
        this.headRemoteAddress = headRemoteAddress;
    }

    public Date getTransmitTime() {
        return transmitTime;
    }

    public void setTransmitTime(Date transmitTime) {
        this.transmitTime = transmitTime;
    }

    public String getUnderWaterInstantDepth() {
        return underWaterInstantDepth;
    }

    public void setUnderWaterInstantDepth(String underWaterInstantDepth) {
        this.underWaterInstantDepth = underWaterInstantDepth;
    }

    public String getInstantWaterTemp() {
        return instantWaterTemp;
    }

    public void setInstantWaterTemp(String instantWaterTemp) {
        this.instantWaterTemp = instantWaterTemp;
    }

    public String getPowerVoltage() {
        return powerVoltage;
    }

    public void setPowerVoltage(String powerVoltage) {
        this.powerVoltage = powerVoltage;
    }
}